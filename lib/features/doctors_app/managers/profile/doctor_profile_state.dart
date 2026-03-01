import 'package:equatable/equatable.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

sealed class DoctorProfileState extends Equatable {
  const DoctorProfileState();
  @override
  List<Object?> get props => [];
}

final class DoctorProfileInitial extends DoctorProfileState {}

final class DoctorProfileLoading extends DoctorProfileState {}

final class DoctorProfileLoaded extends DoctorProfileState {
  final Doctor doctor;
  const DoctorProfileLoaded(this.doctor);
  @override
  List<Object?> get props => [doctor];
}

final class DoctorProfileUpdating extends DoctorProfileState {}

final class DoctorProfileError extends DoctorProfileState {
  final String message;
  const DoctorProfileError(this.message);
  @override
  List<Object?> get props => [message];
}
