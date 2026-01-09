import 'package:equatable/equatable.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/entities/waitlist_entry.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/repos/waitlist_repo.dart';

abstract class WaitlistState extends Equatable {
  const WaitlistState();

  @override
  List<Object?> get props => [];
}

class WaitlistInitial extends WaitlistState {}

class WaitlistLoading extends WaitlistState {}

class WaitlistJoining extends WaitlistState {}

class WaitlistLeaving extends WaitlistState {}

class WaitlistAccepting extends WaitlistState {}

class WaitlistDeclining extends WaitlistState {}

class WaitlistLoaded extends WaitlistState {
  final List<WaitlistEntry> waitlists;

  const WaitlistLoaded({required this.waitlists});

  @override
  List<Object?> get props => [waitlists];
}

class WaitlistJoined extends WaitlistState {
  final WaitlistEntry entry;
  final int position;

  const WaitlistJoined({required this.entry, required this.position});

  @override
  List<Object?> get props => [entry, position];
}

class WaitlistLeft extends WaitlistState {}

class WaitlistSlotAccepted extends WaitlistState {
  final dynamic appointment;

  const WaitlistSlotAccepted({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class WaitlistSlotDeclined extends WaitlistState {}

class WaitlistPositionLoaded extends WaitlistState {
  final WaitlistPositionInfo positionInfo;

  const WaitlistPositionLoaded({required this.positionInfo});

  @override
  List<Object?> get props => [positionInfo];
}

class DoctorAvailabilityLoaded extends WaitlistState {
  final DoctorAvailabilityInfo availabilityInfo;

  const DoctorAvailabilityLoaded({required this.availabilityInfo});

  @override
  List<Object?> get props => [availabilityInfo];
}

class WaitlistError extends WaitlistState {
  final String message;

  const WaitlistError({required this.message});

  @override
  List<Object?> get props => [message];
}

class WaitlistSlotAvailable extends WaitlistState {
  final WaitlistEntry entry;

  const WaitlistSlotAvailable({required this.entry});

  @override
  List<Object?> get props => [entry];
}
