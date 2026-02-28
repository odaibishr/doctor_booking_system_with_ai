import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_appointment_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class DoctorAppointmentRepoImpl implements DoctorAppointmentRepo {
  final DoctorAppointmentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DoctorAppointmentRepoImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<DoctorAppointment>>> getAppointments({
    String? status,
    String? date,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getAppointments(
        status: status,
        date: date,
      );
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorAppointment>> getAppointmentDetails(
    int id,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getAppointmentDetails(id);
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorAppointment>>>
  getHistoryAppointments() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getHistoryAppointments();
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorAppointment>>>
  getTodayAppointments() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getTodayAppointments();
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorAppointment>>>
  getUpcomingAppointments() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getUpcomingAppointments();
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorAppointment>> updateAppointmentStatus({
    required int id,
    required String status,
    String? cancellationReason,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.updateAppointmentStatus(
        id: id,
        status: status,
        cancellationReason: cancellationReason,
      );
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
