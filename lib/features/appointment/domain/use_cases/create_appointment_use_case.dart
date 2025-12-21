import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/entities/appointment.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/repos/appoinment_repo.dart';

class CreateAppointmentUseCase
    extends Usecase<Appointment, CreateAppointmentUseCaseParams> {
  final AppoinmentRepo appoinmentRepo;

  CreateAppointmentUseCase({required this.appoinmentRepo});

  @override
  Future<Either<Failure, Appointment>> call([
    CreateAppointmentUseCaseParams? params,
  ]) async {
    return await appoinmentRepo.createAppointment(
      doctorId: params!.doctorId,
      doctorScheduleId: params.doctorScheduleId,
      transitionId: params.transitionId,
      date: params.date,
      time: params.time,
      statue: params.statue,
    );
  }
}

class CreateAppointmentUseCaseParams {
  final int doctorId;
  final int doctorScheduleId;
  final int transitionId;
  final String date;
  final String time;
  final String statue;

  CreateAppointmentUseCaseParams({
    required this.doctorId,
    required this.doctorScheduleId,
    required this.transitionId,
    required this.date,
    required this.time,
    required this.statue,
  });
}
