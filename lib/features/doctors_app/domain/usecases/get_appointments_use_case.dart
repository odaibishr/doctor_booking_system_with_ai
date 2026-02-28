// This class is used to return current doctor's appointments

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class GetAppointmentsUseCase
    extends Usecase<List<DoctorAppointment>, GetAppointmentsUseCaseParams> {
  final DoctorAppointmentRepo doctorAppointmentRepo;

  GetAppointmentsUseCase(this.doctorAppointmentRepo);

  @override
  Future<Either<Failure, List<DoctorAppointment>>> call([
    GetAppointmentsUseCaseParams? params,
  ]) {
    return doctorAppointmentRepo.getAppointments(
      status: params?.status,
      date: params?.date,
    );
  }
}

class GetAppointmentsUseCaseParams {
  final String? status;
  final String? date;

  const GetAppointmentsUseCaseParams({this.status, this.date});
}