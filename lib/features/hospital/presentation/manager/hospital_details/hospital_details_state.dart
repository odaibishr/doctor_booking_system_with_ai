part of 'hospital_details_cubit.dart';

@immutable
sealed class HospitalDetailsState {}

final class HospitalDetailsInitial extends HospitalDetailsState {}

final class HospitalDetailsLoading extends HospitalDetailsState {}

final class HospitalDetailsLoaded extends HospitalDetailsState {
  final Hospital hospital;
  HospitalDetailsLoaded(this.hospital);
}

final class HospitalDetailsError extends HospitalDetailsState {
  final String errorMessage;
  HospitalDetailsError(this.errorMessage);
}
