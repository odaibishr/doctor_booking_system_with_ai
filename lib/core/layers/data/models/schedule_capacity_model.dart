import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';

class ScheduleCapacity {
  final int totalMinutes;
  final int usedMinutes;
  final int remainingMinutes;
  final bool canAcceptNewPatient;
  final bool canAcceptReturningPatient;
  final int maxNewPatientsRemaining;
  final int maxReturningPatientsRemaining;
  final int bookedCount;
  final int newPatientDuration;
  final int returningPatientDuration;

  ScheduleCapacity({
    required this.totalMinutes,
    required this.usedMinutes,
    required this.remainingMinutes,
    required this.canAcceptNewPatient,
    required this.canAcceptReturningPatient,
    required this.maxNewPatientsRemaining,
    required this.maxReturningPatientsRemaining,
    required this.bookedCount,
    required this.newPatientDuration,
    required this.returningPatientDuration,
  });

  factory ScheduleCapacity.fromMap(Map<String, dynamic> data) {
    return ScheduleCapacity(
      totalMinutes: parseToInt(data['total_minutes']),
      usedMinutes: parseToInt(data['used_minutes']),
      remainingMinutes: parseToInt(data['remaining_minutes']),
      canAcceptNewPatient: data['can_accept_new_patient'] == true,
      canAcceptReturningPatient: data['can_accept_returning_patient'] == true,
      maxNewPatientsRemaining: parseToInt(data['max_new_patients_remaining']),
      maxReturningPatientsRemaining: parseToInt(
        data['max_returning_patients_remaining'],
      ),
      bookedCount: parseToInt(data['booked_count']),
      newPatientDuration: parseToInt(data['new_patient_duration'] ?? 30),
      returningPatientDuration: parseToInt(
        data['returning_patient_duration'] ?? 15,
      ),
    );
  }

  String get formattedRemainingTime {
    final hours = remainingMinutes ~/ 60;
    final minutes = remainingMinutes % 60;
    if (hours > 0) {
      return '$hours ساعة و $minutes دقيقة';
    }
    return '$minutes دقيقة';
  }

  bool canAcceptPatient(bool isReturning) {
    return isReturning ? canAcceptReturningPatient : canAcceptNewPatient;
  }

  int getPatientDuration(bool isReturning) {
    return isReturning ? returningPatientDuration : newPatientDuration;
  }
}
