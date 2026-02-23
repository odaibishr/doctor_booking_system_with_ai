import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_keys.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';

Query<Either<Failure, List<Booking>>> bookingHistoryQuery() {
  return Query<Either<Failure, List<Booking>>>(
    key: QueryKeys.bookingHistory,
    queryFn: () => serviceLocator<BookingHistoryRepo>().getBookingHistory(),
    config: AppQueryConfig.frequentUpdateConfig,
  );
}

void invalidateBookingHistoryCache() {
  AppQueryConfig.invalidateQuery(QueryKeys.bookingHistory);
}
