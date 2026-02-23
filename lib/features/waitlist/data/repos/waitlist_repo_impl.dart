import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/errors/exceptions.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/data/datasources/waitlist_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/entities/waitlist_entry.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/repos/waitlist_repo.dart';

class WaitlistRepoImpl implements WaitlistRepo {
  final WaitlistRemoteDataSource remoteDataSource;

  WaitlistRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, WaitlistEntry>> joinWaitlist({
    required int doctorId,
    String? preferredDate,
    int? preferredScheduleId,
  }) async {
    try {
      final result = await remoteDataSource.joinWaitlist(
        doctorId: doctorId,
        preferredDate: preferredDate,
        preferredScheduleId: preferredScheduleId,
      );
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, void>> leaveWaitlist(int waitlistId) async {
    try {
      await remoteDataSource.leaveWaitlist(waitlistId);
      return const Right(null);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<WaitlistEntry>>> getMyWaitlists() async {
    try {
      final result = await remoteDataSource.getMyWaitlists();
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, WaitlistPositionInfo>> getPosition(
    int doctorId,
  ) async {
    try {
      final result = await remoteDataSource.getPosition(doctorId);
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, dynamic>> acceptSlot({
    required int waitlistId,
    required String date,
    required int doctorScheduleId,
    required String paymentMode,
  }) async {
    try {
      final result = await remoteDataSource.acceptSlot(
        waitlistId: waitlistId,
        date: date,
        doctorScheduleId: doctorScheduleId,
        paymentMode: paymentMode,
      );
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, void>> declineSlot(int waitlistId) async {
    try {
      await remoteDataSource.declineSlot(waitlistId);
      return const Right(null);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, DoctorAvailabilityInfo>> checkDoctorAvailability(
    int doctorId,
  ) async {
    try {
      final result = await remoteDataSource.checkDoctorAvailability(doctorId);
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  Either<Failure, T> _handleError<T>(dynamic e) {
    if (e is DioException) {
      try {
        handleDioException(e);
      } catch (e2) {
        if (e2 is ServerException) {
          return Left(Failure(e2.errorModel.errorMessage));
        }
        return Left(Failure(e2.toString()));
      }
    }
    if (e is ServerException) {
      return Left(Failure(e.errorModel.errorMessage));
    }
    // Fallback for generic exceptions
    final message = e.toString().replaceFirst('Exception: ', '');
    return Left(Failure(message));
  }
}
