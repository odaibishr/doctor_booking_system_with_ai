class Appointment {
  final int id;
  final int doctorId;
  final int doctorScheduleId;
  final int transitionId;
  final String date;
  final String time;
  final String statue;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorScheduleId,
    required this.transitionId,
    required this.date,
    required this.time,
    required this.statue,
  });
}
