part of 'hospital_cubit.dart';

@immutable
sealed class HospitalState {}

final class HospitalInitial extends HospitalState {}

final class HospitalLoading extends HospitalState {}

final class HospitalLoadded extends HospitalState {
  final List<Hospital> hospitals;

  HospitalLoadded(this.hospitals);
}

final class HospitalError extends HospitalState {
  final String message;

  HospitalError(this.message);
}
