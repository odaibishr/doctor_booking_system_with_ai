part of 'search_doctors_bloc.dart';

@immutable
sealed class SearchDoctorsState {}

final class SearchDoctorsInitial extends SearchDoctorsState {}

final class SearchDoctorsLoading extends SearchDoctorsState {}

final class SearchDoctorsLoaded extends SearchDoctorsState {
  final List<Doctor> doctors;

  SearchDoctorsLoaded(this.doctors);
}

final class SearchDoctorsError extends SearchDoctorsState {
  final String message;

  SearchDoctorsError(this.message);
}
