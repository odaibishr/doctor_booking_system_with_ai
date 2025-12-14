import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/datasources/booking_history_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';

class BookingHistoryRepoImpl implements BookingHistoryRepo {
  final BookingHistoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BookingHistoryRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Booking>>> getBookingHistory() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لا يوجد اتصال بالإنترنت'));
      }

      final result = await remoteDataSource.getBookingHistory();

      if (result.isEmpty) {
        return Left(Failure('لا توجد حجوزات متاحة الآن'));
      }

      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
