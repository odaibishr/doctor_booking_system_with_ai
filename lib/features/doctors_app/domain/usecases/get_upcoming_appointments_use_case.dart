import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class GetUpcomingAppointmentsUseCase
    extends Usecase<List<DoctorAppointment>, NoParams> {
  final DoctorAppointmentRepo repo;

  GetUpcomingAppointmentsUseCase(this.repo);

  @override
  Future<Either<Failure, List<DoctorAppointment>>> call([
    NoParams? params,
  ]) async {
    return await repo.getUpcomingAppointments();
  }
}

class NoParams {}
