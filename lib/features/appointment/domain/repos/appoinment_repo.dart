import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/entities/appointment.dart';

abstract class AppoinmentRepo {
  Future<Either<Failure, Appointment>> createAppointment({
    required int doctorId,
    int? doctorScheduleId,
    String? transactionId,
    required String date,
    required String paymentMode,
    String? status,
    bool? isCompleted,
  });
}
