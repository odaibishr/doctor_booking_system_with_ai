import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';

abstract class ReviewRemoteDataSource {
  Future<List<Review>> getDoctorReviews(int doctorId);
  Future<Review> createReview(Review review);
}

