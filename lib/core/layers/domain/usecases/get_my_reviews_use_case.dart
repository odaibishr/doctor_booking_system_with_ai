// This class is used to ruturn doctor's reviews

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class GetMyReviewsUseCase extends Usecase<({List<Review> reviews, double avgRating, int totalCount}), void> {
  final ReviewRepo reviewRepo;

  GetMyReviewsUseCase(this.reviewRepo);

  @override
  Future<Either<Failure, ({double avgRating, List<Review> reviews, int totalCount})>> call([void params]) {
    return reviewRepo.getMyReviews();
  }
}