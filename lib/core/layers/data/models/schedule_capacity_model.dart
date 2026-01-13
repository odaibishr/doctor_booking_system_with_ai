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
      totalMinutes: _toInt(data['total_minutes']),
      usedMinutes: _toInt(data['used_minutes']),
      remainingMinutes: _toInt(data['remaining_minutes']),
      canAcceptNewPatient: data['can_accept_new_patient'] == true,
      canAcceptReturningPatient: data['can_accept_returning_patient'] == true,
      maxNewPatientsRemaining: _toInt(data['max_new_patients_remaining']),
      maxReturningPatientsRemaining: _toInt(
        data['max_returning_patients_remaining'],
      ),
      bookedCount: _toInt(data['booked_count']),
      newPatientDuration: _toInt(data['new_patient_duration'] ?? 30),
      returningPatientDuration: _toInt(
        data['returning_patient_duration'] ?? 15,
      ),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse('${value ?? ''}') ?? 0;
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
