import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/create_review_use_case.dart';
import 'package:flutter/foundation.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._createReviewUseCase) : super(ReviewInitial());

  final CreateReviewUseCase _createReviewUseCase;
  int _requestId = 0;

  Future<void> createReview({
    required int doctorId,
    required int rating,
    required String comment,
  }) async {
    final requestId = ++_requestId;
    if (isClosed) return;

    emit(ReviewSubmitting());

    try {
      final result = await _createReviewUseCase(
        CreateReviewParams(doctorId: doctorId, rating: rating, comment: comment),
      );

      if (isClosed || requestId != _requestId) return;

      result.fold(
        (failure) {
          if (isClosed || requestId != _requestId) return;
          emit(ReviewFailure(failure.errorMessage));
        },
        (review) {
          if (isClosed || requestId != _requestId) return;
          emit(ReviewSuccess(review));
        },
      );
    } catch (error) {
      if (isClosed || requestId != _requestId) return;
      emit(ReviewFailure(error.toString()));
    }
  }

  @override
  Future<void> close() {
    _requestId++;
    return super.close();
  }
}

