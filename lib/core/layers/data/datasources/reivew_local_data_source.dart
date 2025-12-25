import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ReivewLocalDataSource {
  Future<List<Review>> getDoctorReviews(int doctorId);
  Future<void> cachedDoctorReviews(List<Review> reviews);
}

class ReivewLocalDataSourceImpl implements ReivewLocalDataSource {
  final Box<Review> _reviewBox;

  ReivewLocalDataSourceImpl(this._reviewBox);

  @override
  Future<List<Review>> getDoctorReviews(int doctorId) async {
    return _reviewBox.values
        .where((review) => review.doctorId == doctorId)
        .toList();
  }

  @override
  Future<void> cachedDoctorReviews(List<Review> reviews) async {
    await _reviewBox.clear();
    await _reviewBox.addAll(reviews);
  }
}
