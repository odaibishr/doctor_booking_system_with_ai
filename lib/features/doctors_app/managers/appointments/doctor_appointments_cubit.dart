import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_appointment_status_use_case.dart';
import 'package:equatable/equatable.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  final UpdateAppointmentStatusUseCase _updateAppointmentStatusUseCase;

  Query<Either<Failure, List<DoctorAppointment>>>? _activeQuery;
  StreamSubscription<QueryState<Either<Failure, List<DoctorAppointment>>>>?
  _querySub;

  DoctorAppointmentsCubit(this._updateAppointmentStatusUseCase)
    : super(DoctorAppointmentsInitial());

  void _safeEmit(DoctorAppointmentsState state) {
    if (!isClosed) emit(state);
  }

  void _listenToQuery(Query<Either<Failure, List<DoctorAppointment>>> query) {
    _querySub?.cancel();
    _activeQuery = query;

    final currentData = query.state.data;
    if (currentData != null) {
      currentData.fold(
        (f) => _safeEmit(DoctorAppointmentsError(f.errorMessage)),
        (list) => _safeEmit(DoctorAppointmentsLoaded(list)),
      );
    } else {
      _safeEmit(DoctorAppointmentsLoading());
    }

    _querySub = query.stream.listen((queryState) {
      if (isClosed) return;
      if (queryState.status == QueryStatus.loading && queryState.data == null) {
        _safeEmit(DoctorAppointmentsLoading());
        return;
      }
      queryState.data?.fold(
        (f) => _safeEmit(DoctorAppointmentsError(f.errorMessage)),
        (list) => _safeEmit(DoctorAppointmentsLoaded(list)),
      );
    });

    // مهم جداً: استدعاء result يضمن أن الـ cached_query سيقوم بإعادة جلب البيانات 
    // من السيرفر إذا كانت الحالة stale (مرفوضة) حتى لو كان الـ cache يحتوي بيانات قديمة.
    query.result;
  }

  void fetchToday() => _listenToQuery(doctorTodayAppointmentsQuery());

  void fetchUpcoming() => _listenToQuery(doctorUpcomingAppointmentsQuery());

  void fetchHistory() => _listenToQuery(doctorHistoryAppointmentsQuery());

  void fetchAppointmentsByStatus(String status) =>
      _listenToQuery(doctorAppointmentsByStatusQuery(status));

  Future<void> updateAppointmentStatus({
    required int id,
    required String status,
    String? cancellationReason,
  }) async {
    if (isClosed) return;

    _safeEmit(DoctorAppointmentsLoading());
    final result = await _updateAppointmentStatusUseCase.call(
      UpdateAppointmentStatusUseCaseParams(
        id: id,
        status: status,
        cancellationReason: cancellationReason,
      ),
    );

    result.fold(
      (failure) => _safeEmit(DoctorAppointmentsError(failure.errorMessage)),
      (appointment) {
        _safeEmit(DoctorAppointmentStatusUpdated(appointment));

        // Optimistic UI Update: Remove from Pending
        CachedQuery.instance.updateQuery(
          key: QueryKeys.doctorAppointmentsByStatus('pending'),
          updateFn: (dynamic oldData) {
            if (oldData is Right<Failure, List<DoctorAppointment>>) {
              final list = oldData.getOrElse(() => []);
              return Right<Failure, List<DoctorAppointment>>(
                list.where((req) => req.id != appointment.id).toList(),
              );
            }
            return oldData;
          },
        );

        // Optimistic UI Update: Add to Target Status (e.g., 'confirmed' or 'cancelled')
        final targetStatus = appointment.status;
        CachedQuery.instance.updateQuery(
          key: QueryKeys.doctorAppointmentsByStatus(targetStatus),
          updateFn: (dynamic oldData) {
            if (oldData is Right<Failure, List<DoctorAppointment>>) {
              final list = oldData.getOrElse(() => []);
              if (!list.any((r) => r.id == appointment.id)) {
                return Right<Failure, List<DoctorAppointment>>([appointment, ...list]);
              }
            }
            return oldData;
          },
        );
        
        invalidateDoctorAppointmentsCache();
        invalidateDoctorDashboardCache();
      },
    );
  }

  @override
  Future<void> close() async {
    await _querySub?.cancel();
    _activeQuery = null;
    return super.close();
  }
}
