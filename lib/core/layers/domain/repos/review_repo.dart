import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';

abstract class ReviewRepo {
  Future<Either<Failure, Review>> createReview(Review review);
  Future<Either<Failure, List<Review>>> getDoctorReviews(int docotrId);
}
