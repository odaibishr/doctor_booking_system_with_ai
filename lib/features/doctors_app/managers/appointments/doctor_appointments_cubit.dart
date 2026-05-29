import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_appointment_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_appointments_by_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_appointments_by_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/services/fcm_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:equatable/equatable.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  final UpdateAppointmentStatusUseCase _updateAppointmentStatusUseCase;
  final WatchTodayAppointmentsUseCase _watchTodayAppointmentsUseCase;
  final RefreshTodayAppointmentsUseCase _refreshTodayAppointmentsUseCase;
  final WatchUpcomingAppointmentsUseCase _watchUpcomingAppointmentsUseCase;
  final RefreshUpcomingAppointmentsUseCase _refreshUpcomingAppointmentsUseCase;
  final WatchHistoryAppointmentsUseCase _watchHistoryAppointmentsUseCase;
  final RefreshHistoryAppointmentsUseCase _refreshHistoryAppointmentsUseCase;
  final WatchAppointmentsByStatusUseCase _watchAppointmentsByStatusUseCase;
  final RefreshAppointmentsByStatusUseCase _refreshAppointmentsByStatusUseCase;
  final PusherService _pusherService;
  final FcmService _fcmService;

  StreamSubscription<Either<Failure, List<DoctorAppointment>>>? _appointmentsSub;
  StreamSubscription? _pusherSub;
  StreamSubscription? _fcmSub;
  
  Future<Either<Failure, void>> Function()? _activeRefresh;

  DoctorAppointmentsCubit({
    required UpdateAppointmentStatusUseCase updateAppointmentStatusUseCase,
    required WatchTodayAppointmentsUseCase watchTodayAppointmentsUseCase,
    required RefreshTodayAppointmentsUseCase refreshTodayAppointmentsUseCase,
    required WatchUpcomingAppointmentsUseCase watchUpcomingAppointmentsUseCase,
    required RefreshUpcomingAppointmentsUseCase refreshUpcomingAppointmentsUseCase,
    required WatchHistoryAppointmentsUseCase watchHistoryAppointmentsUseCase,
    required RefreshHistoryAppointmentsUseCase refreshHistoryAppointmentsUseCase,
    required WatchAppointmentsByStatusUseCase watchAppointmentsByStatusUseCase,
    required RefreshAppointmentsByStatusUseCase refreshAppointmentsByStatusUseCase,
    required PusherService pusherService,
    required FcmService fcmService,
  })  : _updateAppointmentStatusUseCase = updateAppointmentStatusUseCase,
        _watchTodayAppointmentsUseCase = watchTodayAppointmentsUseCase,
        _refreshTodayAppointmentsUseCase = refreshTodayAppointmentsUseCase,
        _watchUpcomingAppointmentsUseCase = watchUpcomingAppointmentsUseCase,
        _refreshUpcomingAppointmentsUseCase = refreshUpcomingAppointmentsUseCase,
        _watchHistoryAppointmentsUseCase = watchHistoryAppointmentsUseCase,
        _refreshHistoryAppointmentsUseCase = refreshHistoryAppointmentsUseCase,
        _watchAppointmentsByStatusUseCase = watchAppointmentsByStatusUseCase,
        _refreshAppointmentsByStatusUseCase = refreshAppointmentsByStatusUseCase,
        _pusherService = pusherService,
        _fcmService = fcmService,
        super(DoctorAppointmentsInitial()) {
    _listenToPusher();
    _listenToFcm();
  }

  void _safeEmit(DoctorAppointmentsState state) {
    if (!isClosed) emit(state);
  }

  void _listenToStream(
    Stream<Either<Failure, List<DoctorAppointment>>> stream,
    Future<Either<Failure, void>> Function() refreshFn,
  ) {
    _appointmentsSub?.cancel();
    _activeRefresh = refreshFn;

    // Check if the stream has a listener before emitting loading to match original Behavior
    _safeEmit(DoctorAppointmentsLoading());

    _appointmentsSub = stream.listen(
      (result) {
        if (isClosed) return;
        result.fold(
          (failure) => _safeEmit(DoctorAppointmentsError(failure.errorMessage)),
          (list) => _safeEmit(DoctorAppointmentsLoaded(list)),
        );
      },
      onError: (error) {
        _safeEmit(DoctorAppointmentsError(error.toString()));
      },
    );
  }

  void fetchToday() {
    _listenToStream(
      _watchTodayAppointmentsUseCase(),
      () => _refreshTodayAppointmentsUseCase(),
    );
  }

  void fetchUpcoming() {
    _listenToStream(
      _watchUpcomingAppointmentsUseCase(),
      () => _refreshUpcomingAppointmentsUseCase(),
    );
  }

  void fetchHistory() {
    _listenToStream(
      _watchHistoryAppointmentsUseCase(),
      () => _refreshHistoryAppointmentsUseCase(),
    );
  }

  void fetchAppointmentsByStatus(String status) {
    _listenToStream(
      _watchAppointmentsByStatusUseCase(status),
      () => _refreshAppointmentsByStatusUseCase(status),
    );
  }

  Future<void> updateAppointmentStatus({
    required int id,
    required String status,
    String? cancellationReason,
  }) async {
    if (isClosed) return;

    final result = await _updateAppointmentStatusUseCase.call(
      UpdateAppointmentStatusUseCaseParams(
        id: id,
        status: status,
        cancellationReason: cancellationReason,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => _safeEmit(DoctorAppointmentsError(failure.errorMessage)),
      (appointment) {
        _safeEmit(DoctorAppointmentStatusUpdated(appointment));
        _activeRefresh?.call();
      },
    );
  }

  void _listenToPusher() {
    _pusherSub?.cancel();
    _pusherSub = _pusherService.eventStream.listen((event) {
      log('DoctorAppointmentsCubit: REAL-TIME EVENT RECEIVED! $event');
      _activeRefresh?.call();
    });
  }

  void _listenToFcm() {
    _fcmSub?.cancel();
    _fcmSub = _fcmService.eventStream.listen((data) {
      log('DoctorAppointmentsCubit: REAL-TIME FCM EVENT RECEIVED! $data');
      final type = data['type']?.toString();
      if (type == 'appointment_created' || type == 'appointment_updated') {
        log('DoctorAppointmentsCubit: Triggering refetch from FCM...');
        _activeRefresh?.call();
      }
    });
  }

  @override
  Future<void> close() async {
    await _appointmentsSub?.cancel();
    await _pusherSub?.cancel();
    await _fcmSub?.cancel();
    _activeRefresh = null;
    return super.close();
  }
}
