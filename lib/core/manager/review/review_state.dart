part of 'review_cubit.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class ReviewSubmitting extends ReviewState {}

final class ReviewSuccess extends ReviewState {
  final Review review;
  ReviewSuccess(this.review);
}

final class ReviewLoaded extends ReviewState {
  final List<Review> reviews;
  ReviewLoaded(this.reviews);
}

final class ReviewLoading extends ReviewState {}

final class ReviewFailure extends ReviewState {
  final String message;
  ReviewFailure(this.message);
}

