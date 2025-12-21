import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/entities/appointment.dart';

abstract class AppoinmentRepo {
  Future<Either<Failure, Appointment>> createAppointment({
    required int doctorId,
    required int doctorScheduleId,
    required int transitionId,
    required String date,
    required String time,
    required String statue,
  });
}
