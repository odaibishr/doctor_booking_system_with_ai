part of 'favorite_doctor_cubit.dart';

@immutable
sealed class FavoriteDoctorState {}

final class FavoriteDoctorInitial extends FavoriteDoctorState {}

final class FavoirteDoctorsLoading extends FavoriteDoctorState {}

final class FavoriteDoctorsLoaded extends FavoriteDoctorState {
  final List<Doctor> doctors;

  FavoriteDoctorsLoaded(this.doctors);
}

final class FavoriteDoctorsError extends FavoriteDoctorState {
  final String message;

  FavoriteDoctorsError(this.message);
}
