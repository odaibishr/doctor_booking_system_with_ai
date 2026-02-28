import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class UpdateAppointmentStatusUseCase
    extends Usecase<DoctorAppointment, UpdateAppointmentStatusUseCaseParams> {
  final DoctorAppointmentRepo repo;

  UpdateAppointmentStatusUseCase(this.repo);

  @override
  Future<Either<Failure, DoctorAppointment>> call([
    UpdateAppointmentStatusUseCaseParams? params,
  ]) async {
    return await repo.updateAppointmentStatus(
      id: params!.id,
      status: params.status,
      cancellationReason: params.cancellationReason,
    );
  }
}

class UpdateAppointmentStatusUseCaseParams {
  final int id;
  final String status;
  final String? cancellationReason;

  UpdateAppointmentStatusUseCaseParams({
    required this.id,
    required this.status,
    this.cancellationReason,
  });
}
