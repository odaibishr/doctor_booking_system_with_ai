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

  static Map<String, dynamic> _ensureMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  static List<dynamic> _ensureList(dynamic value) {
    if (value is List) return value;
    return <dynamic>[];
  }

  @override
  Future<List<Review>> getDoctorReviews(int doctorId) async {
    final response = await dioConsumer.get(
      'review/getReviewByDoctor/$doctorId',
    );

    final data =
        (response is Map && response['data'] != null) ? response['data'] : response;

    final list = _ensureList(data);
    return list
        .whereType<Map>()
        .map((e) => ReviewModel.fromJson(_ensureMap(e)))
        .toList();
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
      throw Exception('تعذر إنشاء المراجعة، حاول مرة أخرى.');
    }

    final data =
        (response is Map && response['data'] != null) ? response['data'] : response;

    return ReviewModel.fromJson(_ensureMap(data));
  }
}

