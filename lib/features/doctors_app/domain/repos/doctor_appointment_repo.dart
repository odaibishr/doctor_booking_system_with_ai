import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';

abstract class DoctorAppointmentRepo {
  Future<Either<Failure, List<DoctorAppointment>>> getAppointments({
    String? status,
    String? date,
  });

  Future<Either<Failure, List<DoctorAppointment>>> getTodayAppointments();
}
