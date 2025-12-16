import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required super.id,
    required super.doctorId,
    required super.userId,
    required super.comment,
    required super.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json['id'] as int,
    doctorId: json['doctor_id'] as int,
    userId: json['user_id'] as int,
    comment: json['comment'] as String,
    rating: json['rating'] as int,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'doctor_id': doctorId,
    'user_id': userId,
    'comment': comment,
    'rating': rating,
  };

  factory ReviewModel.fromMap(Map<String, dynamic> map) => ReviewModel(
    id: map['id'] as int,
    doctorId: map['doctor_id'] as int,
    userId: map['user_id'] as int,
    comment: map['comment'] as String,
    rating: map['rating'] as int,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'doctor_id': doctorId,
    'user_id': userId,
    'comment': comment,
    'rating': rating,
  };
}
