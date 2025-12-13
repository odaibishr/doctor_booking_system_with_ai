part of 'hospital_detailes_cubit.dart';

@immutable
sealed class HospitalDetailesState {}

final class HospitalDetailesInitial extends HospitalDetailesState {}

final class HospitalDetailesLoading extends HospitalDetailesState {}

final class HospitalDetailesLoaded extends HospitalDetailesState {
  final Hospital hospital;
  HospitalDetailesLoaded(this.hospital);
}

final class HospitalDetailesError extends HospitalDetailesState {
  final String errorMessage;
  HospitalDetailesError(this.errorMessage);
}
