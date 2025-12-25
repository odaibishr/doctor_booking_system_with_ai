class Appointment {
  final int id;
  final int doctorId;
  final int? doctorScheduleId;
  final String? transactionId;
  final String date;
  final String paymentMode;
  final String status;
  final bool isCompleted;

  Appointment({
    required this.id,
    required this.doctorId,
    this.doctorScheduleId,
    this.transactionId = '1',
    required this.date,
    required this.paymentMode,
    required this.status,
    this.isCompleted = false,
  });
}
