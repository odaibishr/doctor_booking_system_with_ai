import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_keys.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';

Query<Either<Failure, List<Review>>> doctorReviewsQuery(int doctorId) {
  return Query<Either<Failure, List<Review>>>(
    key: QueryKeys.doctorReviews(doctorId),
    queryFn: () => serviceLocator<ReviewRepo>().getDoctorReviews(doctorId),
    config: QueryConfig(
      refetchDuration: AppQueryConfig.frequentUpdateConfig.refetchDuration,
      cacheDuration: AppQueryConfig.frequentUpdateConfig.cacheDuration,
      storageDeserializer: (dynamic data) {
        if (data == null) return null;
        if (data is List) {
          return Right(data.cast<Review>());
        }
        return data;
      },
    ),
  );
}

void invalidateDoctorReviewsCache(int doctorId) {
  AppQueryConfig.invalidateQuery(QueryKeys.doctorReviews(doctorId));
}
