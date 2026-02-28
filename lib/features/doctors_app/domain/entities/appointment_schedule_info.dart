class AppointmentScheduleInfo {
  final int id;
  final String startTime;
  final String endTime;
  final String? dayName;

  AppointmentScheduleInfo({
    required this.id,
    required this.startTime,
    required this.endTime,
    this.dayName,
  });
}
