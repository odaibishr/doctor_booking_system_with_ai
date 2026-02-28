part of 'doctor_appointments_cubit.dart';

sealed class DoctorAppointmentsState extends Equatable {
  const DoctorAppointmentsState();

  @override
  List<Object> get props => [];
}

final class DoctorAppointmentsInitial extends DoctorAppointmentsState {}
