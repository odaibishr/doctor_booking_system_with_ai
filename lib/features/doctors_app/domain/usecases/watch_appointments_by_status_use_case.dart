import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class WatchAppointmentsByStatusUseCase {
  final DoctorAppointmentRepo doctorAppointmentRepo;

  WatchAppointmentsByStatusUseCase(this.doctorAppointmentRepo);

  Stream<Either<Failure, List<DoctorAppointment>>> call(String status) {
    return doctorAppointmentRepo.watchAppointmentsByStatus(status);
  }
}
