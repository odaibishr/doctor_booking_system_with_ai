import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';

class Review {
  final int id;
  final int doctorId;
  final int userId;
  final String comment;
  final int rating;
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
