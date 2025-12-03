part of 'doctor_details_cubit.dart';

sealed class DoctorDetailsState {}

final class DoctorDetailsInitial extends DoctorDetailsState {}

final class DoctorDetailsLoading extends DoctorDetailsState {}

final class DoctorDetailsLoaded extends DoctorDetailsState {
  final Doctor doctor;
  DoctorDetailsLoaded({required this.doctor});
}

final class DoctorDetailsError extends DoctorDetailsState {
  final String message;
  DoctorDetailsError({required this.message});
}
