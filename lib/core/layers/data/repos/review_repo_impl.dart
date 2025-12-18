import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/review_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';

class ReviewRepoImpl implements ReviewRepo {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepoImpl(this.remoteDataSource);
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
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getDoctorReviews(int docotrId) async {
    try {
      final reviews = await remoteDataSource.getDoctorReviews(docotrId);
      return Right(reviews);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
