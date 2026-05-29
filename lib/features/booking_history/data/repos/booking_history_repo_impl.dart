import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/queries/booking_query.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
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
      return Left(Failure('فشل إلغاء الموعد، يرجى المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, void>> rescheduleAppointment(
    int appointmentId,
    String date,
    int? scheduleId,
  ) async {
    try {
      await remoteDataSource.rescheduleAppointment(
        appointmentId,
        date,
        scheduleId,
      );
      return Right(null);
    } catch (error) {
      return Left(Failure('فشل تعديل الموعد، يرجى المحاولة لاحقاً'));
    }
  }

  @override
  Stream<Either<Failure, List<Booking>>> watchBookingHistory() {
    final query = bookingHistoryQuery();
    final controller = StreamController<Either<Failure, List<Booking>>>.broadcast();

    if (query.state.data != null) {
      controller.add(query.state.data!);
    }

    final subscription = query.stream.listen((state) {
      if (state.data != null) {
        controller.add(state.data!);
      }
    });

    final isStale = query.state.status == QueryStatus.initial ||
        DateTime.now().difference(query.state.timeCreated) >
            AppQueryConfig.defaultRefetchDuration;

    if (isStale) {
      query.refetch();
    }

    controller.onCancel = () {
      subscription.cancel();
      controller.close();
    };

    return controller.stream;
  }

  @override
  Future<Either<Failure, void>> refreshBookingHistory() async {
    try {
      final query = bookingHistoryQuery();
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
