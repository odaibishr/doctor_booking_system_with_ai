import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';

class WatchDoctorReviewsUseCase {
  final ReviewRepo reviewRepo;

  WatchDoctorReviewsUseCase(this.reviewRepo);

  Stream<Either<Failure, List<Review>>> call(int doctorId) {
    return reviewRepo.watchDoctorReviews(doctorId);
  }
}
