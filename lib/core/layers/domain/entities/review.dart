class Review {
  final int id;
  final int doctorId;
  final int userId;
  final String comment;
  final int rating;

  Review({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.comment,
    required this.rating,
  });
}
