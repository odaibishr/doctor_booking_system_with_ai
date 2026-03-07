import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_appointment_status_use_case.dart';
import 'package:equatable/equatable.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  final GetTodayAppointmentsUseCase _getTodayAppointmentsUseCase;
  final GetUpcomingAppointmentsUseCase _getUpcomingAppointmentsUseCase;
  final GetHistoryAppointmentsUseCase _getHistoryAppointmentsUseCase;
  final UpdateAppointmentStatusUseCase _updateAppointmentStatusUseCase;
  DoctorAppointmentsCubit(
    this._getTodayAppointmentsUseCase,
    this._getUpcomingAppointmentsUseCase,
    this._getHistoryAppointmentsUseCase,
    this._updateAppointmentStatusUseCase,
  ) : super(DoctorAppointmentsInitial());

  void _safeEmit(DoctorAppointmentsState state) {
    if (!isClosed) emit(state);
  }

  Future<void> fetchUpcoming() async {
    if (isClosed) return;

    _safeEmit(DoctorAppointmentsLoading());
    try {
      final result = await _getUpcomingAppointmentsUseCase.call();
      result.fold(
        (failure) => _safeEmit(DoctorAppointmentsError(failure.errorMessage)),
        (appointments) => _safeEmit(DoctorAppointmentsLoaded(appointments)),
      );
    } catch (e) {
      _safeEmit(DoctorAppointmentsError(e.toString()));
    }
  }

  Future<void> fetchHistory() async {
    if (isClosed) return;

    _safeEmit(DoctorAppointmentsLoading());
    try {
      final result = await _getHistoryAppointmentsUseCase.call();
      result.fold(
        (failure) => _safeEmit(DoctorAppointmentsError(failure.errorMessage)),
        (appointments) => _safeEmit(DoctorAppointmentsLoaded(appointments)),
      );
    } catch (e) {
      _safeEmit(DoctorAppointmentsError(e.toString()));
    }
  }

  Future<void> fetchToday() async {
    if (isClosed) return;

    _safeEmit(DoctorAppointmentsLoading());
    try {
      final result = await _getTodayAppointmentsUseCase.call();
      result.fold(
        (failure) => _safeEmit(DoctorAppointmentsError(failure.errorMessage)),
        (appointments) => _safeEmit(DoctorAppointmentsLoaded(appointments)),
      );
    } catch (e) {
      _safeEmit(DoctorAppointmentsError(e.toString()));
    }
  }

  Future<void> updateAppointmentStatus({
    required int id,
    required String status,
    String? cancellationReason,
  }) async {
    if (isClosed) return;

    _safeEmit(DoctorAppointmentsLoading());
    try {
      final result = await _updateAppointmentStatusUseCase.call(
        UpdateAppointmentStatusUseCaseParams(
          id: id,
          status: status,
          cancellationReason: cancellationReason,
        ),
      );
      result.fold(
        (failure) => _safeEmit(DoctorAppointmentsError(failure.errorMessage)),
        (appointment) => _safeEmit(DoctorAppointmentStatusUpdated(appointment)),
      );
    } catch (e) {
      _safeEmit(DoctorAppointmentsError(e.toString()));
    }
  }
}
