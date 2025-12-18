part of 'review_cubit.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class ReviewSubmitting extends ReviewState {}

final class ReviewSuccess extends ReviewState {
  final Review review;
  ReviewSuccess(this.review);
}

final class ReviewFailure extends ReviewState {
  final String message;
  ReviewFailure(this.message);
}

