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

  Future<void> fetchUpcoming() async {
    if (isClosed) return;

    emit(DoctorAppointmentsLoading());
    try {
      final result = await _getUpcomingAppointmentsUseCase.call();
      result.fold(
        (failure) => emit(DoctorAppointmentsError(failure.errorMessage)),
        (appointments) => emit(DoctorAppointmentsLoaded(appointments)),
      );
    } catch (e) {
      emit(DoctorAppointmentsError(e.toString()));
    }
  }

  Future<void> fetchHistory() async {
    if (isClosed) return;

    emit(DoctorAppointmentsLoading());
    try {
      final result = await _getHistoryAppointmentsUseCase.call();
      result.fold(
        (failure) => emit(DoctorAppointmentsError(failure.errorMessage)),
        (appointments) => emit(DoctorAppointmentsLoaded(appointments)),
      );
    } catch (e) {
      emit(DoctorAppointmentsError(e.toString()));
    }
  }

  Future<void> fetchToday() async {
    if (isClosed) return;

    emit(DoctorAppointmentsLoading());
    try {
      final result = await _getTodayAppointmentsUseCase.call();
      result.fold(
        (failure) => emit(DoctorAppointmentsError(failure.errorMessage)),
        (appointments) => emit(DoctorAppointmentsLoaded(appointments)),
      );
    } catch (e) {
      emit(DoctorAppointmentsError(e.toString()));
    }
  }

  Future<void> updateAppointmentStatus({
    required int id,
    required String status,
    String? cancellationReason,
  }) async {
    if (isClosed) return;

    emit(DoctorAppointmentsLoading());
    try {
      final result = await _updateAppointmentStatusUseCase.call(
        UpdateAppointmentStatusUseCaseParams(
          id: id,
          status: status,
          cancellationReason: cancellationReason,
        ),
      );
      result.fold(
        (failure) => emit(DoctorAppointmentsError(failure.errorMessage)),
        (appointment) => emit(DoctorAppointmentStatusUpdated(appointment)),
      );
    } catch (e) {
      emit(DoctorAppointmentsError(e.toString()));
    }
  }
}
