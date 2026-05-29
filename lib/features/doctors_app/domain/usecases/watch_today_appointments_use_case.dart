import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class WatchTodayAppointmentsUseCase {
  final DoctorAppointmentRepo doctorAppointmentRepo;

  WatchTodayAppointmentsUseCase(this.doctorAppointmentRepo);

  Stream<Either<Failure, List<DoctorAppointment>>> call() {
    return doctorAppointmentRepo.watchTodayAppointments();
  }
}
