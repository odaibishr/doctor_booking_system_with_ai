import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'review.g.dart';

@HiveType(typeId: 7)
class Review {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int doctorId;
  @HiveField(2)
  final int userId;
  @HiveField(3)
  final String comment;
  @HiveField(4)
  final int rating;
  @HiveField(5)
  final User? user;

  Review({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.comment,
    required this.rating,
    this.user,
  });
}
