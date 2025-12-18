import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/review_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';

abstract class ReviewRemoteDataSource {
  Future<List<Review>> getDoctorReviews(int doctorId);
  Future<Review> createReview({
    required int doctorId,
    required int rating,
    required String comment,
  });
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final DioConsumer dioConsumer;

  ReviewRemoteDataSourceImpl(this.dioConsumer);
  @override
  Future<List<Review>> getDoctorReviews(int doctorId) async {
    final response = await dioConsumer.get(
      'review/getReviewByDoctor/$doctorId',
    );

    return ReviewModel.fromJson(response) as List<Review>;
  }

  @override
  Future<Review> createReview({
    required int doctorId,
    required int rating,
    required String comment,
  }) async {
    final response = await dioConsumer.post(
      'review/createReview',
      data: {'doctor_id': doctorId, 'rating': rating, 'comment': comment},
    );

    if (response == null) {
      throw Exception("فشل في إنشاء المراجعة. الرجاء المحاولة مرة أخرى.");
    }

    return ReviewModel.fromJson(response);
  }
}
