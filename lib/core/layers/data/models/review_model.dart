import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/models/user_model.dart';

class ReviewModel extends Review {
  ReviewModel({
    required super.id,
    required super.doctorId,
    required super.userId,
    required super.comment,
    required super.rating,
    super.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: _toInt(json['id']),
        doctorId: _toInt(json['doctor_id'] ?? json['doctorId']),
        userId: _toInt(json['user_id'] ?? json['userId']),
        comment: (json['comment'] ?? '').toString(),
        rating: _toInt(json['rating']),
        user: json['user'] is Map
            ? UserModel.fromJson(
                (json['user'] as Map).map((k, v) => MapEntry(k.toString(), v)),
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'doctor_id': doctorId,
    'user_id': userId,
    'comment': comment,
    'rating': rating,
  };

  factory ReviewModel.fromMap(Map<String, dynamic> map) => ReviewModel(
        id: _toInt(map['id']),
        doctorId: _toInt(map['doctor_id'] ?? map['doctorId']),
        userId: _toInt(map['user_id'] ?? map['userId']),
        comment: (map['comment'] ?? '').toString(),
        rating: _toInt(map['rating']),
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'doctor_id': doctorId,
    'user_id': userId,
    'comment': comment,
    'rating': rating,
  };

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse('${value ?? ''}') ?? 0;
  }
}
