import 'package:equatable/equatable.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';

sealed class DoctorScheduleState extends Equatable {
  const DoctorScheduleState();
  @override
  List<Object?> get props => [];
}

final class DoctorScheduleInitial extends DoctorScheduleState {}

final class DoctorScheduleLoading extends DoctorScheduleState {}

final class DoctorScheduleLoaded extends DoctorScheduleState {
  final List<DoctorSchedule> schedules;
  final List<DoctorDayOff> daysOff;

  const DoctorScheduleLoaded({required this.schedules, required this.daysOff});

  @override
  List<Object?> get props => [schedules, daysOff];
}

final class DoctorScheduleError extends DoctorScheduleState {
  final String message;
  const DoctorScheduleError(this.message);
  @override
  List<Object?> get props => [message];
}
