import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class GetAppointmentDetailsUseCase
    extends Usecase<DoctorAppointment, GetAppointmentDetailsUseCaseParams> {
  final DoctorAppointmentRepo repo;

  GetAppointmentDetailsUseCase(this.repo);

  @override
  Future<Either<Failure, DoctorAppointment>> call([
    GetAppointmentDetailsUseCaseParams? params,
  ]) async {
    return await repo.getAppointmentDetails(params!.id);
  }
}

class GetAppointmentDetailsUseCaseParams {
  final int id;

  GetAppointmentDetailsUseCaseParams({required this.id});
}
