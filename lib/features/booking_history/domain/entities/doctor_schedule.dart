class DoctorSchedule {
  final int id;
  final int doctorId;
  final int dayId;
  final String startTime;
  final String endTime;
  final String createdAt;
  final String updatedAt;

  DoctorSchedule({
    required this.id,
    required this.doctorId,
    required this.dayId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });
}
