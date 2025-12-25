import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/data/data_sources/appointment_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/entities/appointment.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/repos/appoinment_repo.dart';

class AppointmentRepoImpl implements AppoinmentRepo {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Appointment>> createAppointment({
    required int doctorId,
    int? doctorScheduleId,
    String? transactionId,
    required String date,
    required String paymentMode,
    String? status,
    bool? isCompleted,
  }) async {
    try {
      final appointment = await remoteDataSource.createAppointment(
        doctorId: doctorId,
        doctorScheduleId: doctorScheduleId,
        transactionId: transactionId,
        date: date,
        paymentMode: paymentMode,
        status: status,
        isCompleted: isCompleted,
      );
      return Right(appointment);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
