part of 'doctor_appointments_cubit.dart';

sealed class DoctorAppointmentsState extends Equatable {
  const DoctorAppointmentsState();

  @override
  List<Object> get props => [];
}

final class DoctorAppointmentsInitial extends DoctorAppointmentsState {}

final class DoctorAppointmentsLoading extends DoctorAppointmentsState {}

final class DoctorAppointmentsLoaded extends DoctorAppointmentsState {
  final List<DoctorAppointment> appointments;

  const DoctorAppointmentsLoaded(this.appointments);
}

final class DoctorAppointmentsError extends DoctorAppointmentsState {
  final String message;

  const DoctorAppointmentsError(this.message);
}

final class DoctorAppointmentStatusUpdating extends DoctorAppointmentsState {}

final class DoctorAppointmentStatusUpdated extends DoctorAppointmentsState {
  final DoctorAppointment appointment;

  const DoctorAppointmentStatusUpdated(this.appointment);
}

final class DoctorAppointmentStatusUpdatedError
    extends DoctorAppointmentsState {
  final String message;

  const DoctorAppointmentStatusUpdatedError(this.message);
}
