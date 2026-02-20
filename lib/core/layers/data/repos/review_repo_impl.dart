import 'package:dartz/dartz.dart';
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
  }) async {
    try {
      final review = await remoteDataSource.createReview(
        doctorId: doctorId,
        rating: rating,
        comment: comment,
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
}
