import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';

abstract class DoctorAppointmentRepo {
  Future<Either<Failure, List<DoctorAppointment>>> getAppointments({
    String? status,
    String? date,
  });

  Future<Either<Failure, List<DoctorAppointment>>> getTodayAppointments();
  Future<Either<Failure, List<DoctorAppointment>>> getUpcomingAppointments();
  Future<Either<Failure, List<DoctorAppointment>>> getHistoryAppointments();
  Future<Either<Failure, DoctorAppointment>> getAppointmentDetails(int id);
  Future<Either<Failure, DoctorAppointment>> updateAppointmentStatus({
    required int id,
    required String status,
    String? cancellationReason,
  });
}
