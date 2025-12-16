import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class CreateReviewUseCase extends Usecase<Review, CreateReviewParams> {
  final ReviewRepo reviewRepo;

  CreateReviewUseCase(this.reviewRepo);
  @override
  Future<Either<Failure, Review>> call([CreateReviewParams? params]) async {
    return await reviewRepo.createReview(
      doctorId: params!.doctorId,
      rating: params.rating,
      comment: params.comment,
    );
  }
}

class CreateReviewParams {
  final int doctorId;
  final int rating;
  final String comment;

  CreateReviewParams({
    required this.doctorId,
    required this.rating,
    required this.comment,
  });
}
