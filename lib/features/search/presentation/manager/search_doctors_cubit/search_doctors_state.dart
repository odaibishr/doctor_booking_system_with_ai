part of 'search_doctors_cubit.dart';

sealed class SearchDoctorsState extends Equatable {
  const SearchDoctorsState();

  @override
  List<Object> get props => [];
}

final class SearchDoctorsInitial extends SearchDoctorsState {}

final class SearchDoctorloading extends SearchDoctorsState {}

final class SearchDoctorsLoaded extends SearchDoctorsState {
  final List<Doctor> doctors;

  const SearchDoctorsLoaded(this.doctors);
}

final class SearchDoctorsError extends SearchDoctorsState {
  final String message;

  const SearchDoctorsError(this.message);
}
