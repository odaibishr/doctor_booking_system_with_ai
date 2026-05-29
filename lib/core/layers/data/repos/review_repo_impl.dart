import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/queries/reviews_query.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/reivew_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/review_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';

class ReviewRepoImpl implements ReviewRepo {
  final ReviewRemoteDataSource remoteDataSource;
  final ReviewLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ReviewRepoImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);
  @override
  Future<Either<Failure, Review>> createReview({
    required int doctorId,
    required int rating,
    required String comment,
    required bool isActive,
  }) async {
    try {
      final review = await remoteDataSource.createReview(
        doctorId: doctorId,
        rating: rating,
        comment: comment,
        isActive: isActive,
      );

      return Right(review);
    } catch (error) {
      return Left(Failure('فشل إضافة المراجعة، يرجى المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getDoctorReviews(int docotrId) async {
    try {
      if (!await networkInfo.isConnected) {
        final reviews = await localDataSource.getDoctorReviews(docotrId);
        if (reviews.isEmpty) {
          return Left(Failure('لا يوجد مراجعات لهذا الطبيب'));
        }
        return Right(reviews);
      }
      final reviews = await remoteDataSource.getDoctorReviews(docotrId);
      if (reviews.isEmpty) {
        return Left(Failure('لا يوجد مراجعات لهذا الطبيب'));
      }
      await localDataSource.cachedDoctorReviews(reviews);
      return Right(reviews);
    } catch (error) {
      return Left(Failure('فشل جلب المراجعات، يرجى المحاولة لاحقاً'));
    }
  }

  @override
  Future<
    Either<Failure, ({double avgRating, List<Review> reviews, int totalCount})>
  >
  getMyReviews() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getMyReviews();
      return Right(result);
    } catch (error) {
      return Left(Failure('فشل جلب المراجعات، يرجى المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, void>> toggleReviewActive(int reviewId) async {
    try {
      await remoteDataSource.toggleReviewActive(reviewId);
      return const Right(null);
    } catch (error) {
      return Left(Failure('فشل تغيير حالة المراجعة'));
    }
  }

  @override
  Stream<Either<Failure, List<Review>>> watchDoctorReviews(int doctorId) {
    final query = doctorReviewsQuery(doctorId);
    final controller = StreamController<Either<Failure, List<Review>>>.broadcast();

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
  Future<Either<Failure, void>> refreshDoctorReviews(int doctorId) async {
    try {
      final query = doctorReviewsQuery(doctorId);
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
