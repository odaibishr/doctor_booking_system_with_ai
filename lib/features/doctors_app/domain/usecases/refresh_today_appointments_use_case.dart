import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class RefreshTodayAppointmentsUseCase {
  final DoctorAppointmentRepo doctorAppointmentRepo;

  RefreshTodayAppointmentsUseCase(this.doctorAppointmentRepo);

  Future<Either<Failure, void>> call() async {
    return await doctorAppointmentRepo.refreshTodayAppointments();
  }
}
