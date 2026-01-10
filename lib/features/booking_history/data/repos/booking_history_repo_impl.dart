import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/datasources/booking_history_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/datasources/booking_history_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';

class BookingHistoryRepoImpl implements BookingHistoryRepo {
  final BookingHistoryRemoteDataSource remoteDataSource;
  final BookingHistoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BookingHistoryRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Booking>>> getBookingHistory() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedBookings = await localDataSource.getCachedBookingHistory();
        if (cachedBookings.isEmpty) {
          return Left(Failure('لا توجد حجوزات متاحة الآن'));
        }
        return Right(cachedBookings);
      }

      final result = await remoteDataSource.getBookingHistory();

      if (result.isEmpty) {
        return Left(Failure('لا توجد حجوزات متاحة الآن'));
      }

      await localDataSource.cachedBookingHistory(result);
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment(
    int appointmentId,
    String reason,
  ) async {
    try {
      await remoteDataSource.cancelAppointment(appointmentId, reason);
      return Right(null);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
