part of 'doctor_cubit.dart';

sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

final class DoctorsLoading extends DoctorState {}

final class DoctorsLoaded extends DoctorState {
  final List<Doctor> doctors;
  DoctorsLoaded({required this.doctors});
}

final class DoctorsError extends DoctorState {
  final String message;
  DoctorsError({required this.message});
}

final class DoctorDetailsLoading extends DoctorState {}

final class DoctorDetailsLoaded extends DoctorState {
  final Doctor doctor;
  DoctorDetailsLoaded({required this.doctor});
}

final class DoctorDetailsError extends DoctorState {
  final String message;
  DoctorDetailsError({required this.message});
}
