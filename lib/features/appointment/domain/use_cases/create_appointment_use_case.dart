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
      transactionId: params.transactionId,
      date: params.date,
      paymentMode: params.paymentMode,
    );
  }
}

class CreateAppointmentUseCaseParams {
  final int doctorId;
  final int? doctorScheduleId;
  final String? transactionId;
  final String date;
  final String paymentMode;

  CreateAppointmentUseCaseParams({
    required this.doctorId,
    this.doctorScheduleId,
    this.transactionId,
    required this.date,
    required this.paymentMode,
  });
}
