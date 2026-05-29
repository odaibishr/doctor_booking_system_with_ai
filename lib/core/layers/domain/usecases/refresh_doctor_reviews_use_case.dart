import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';

class RefreshDoctorReviewsUseCase {
  final ReviewRepo reviewRepo;

  RefreshDoctorReviewsUseCase(this.reviewRepo);

  Future<void> call(int doctorId) async {
    await reviewRepo.refreshDoctorReviews(doctorId);
  }
}
