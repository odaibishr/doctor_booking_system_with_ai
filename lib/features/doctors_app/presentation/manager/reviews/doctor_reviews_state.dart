import 'package:equatable/equatable.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';

sealed class DoctorReviewsState extends Equatable {
  const DoctorReviewsState();

  @override
  List<Object> get props => [];
}

final class DoctorReviewsInitial extends DoctorReviewsState {}

final class DoctorReviewsLoading extends DoctorReviewsState {}

final class DoctorReviewsLoaded extends DoctorReviewsState {
  final List<Review> reviews;
  final double avgRating;
  final int totalCount;

  const DoctorReviewsLoaded({
    required this.reviews,
    required this.avgRating,
    required this.totalCount,
  });

  @override
  List<Object> get props => [reviews, avgRating, totalCount];
}

final class DoctorReviewsError extends DoctorReviewsState {
  final String message;

  const DoctorReviewsError(this.message);

  @override
  List<Object> get props => [message];
}
