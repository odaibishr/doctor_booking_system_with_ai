import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/create_review_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctor_reviews_use_case.dart';
import 'package:flutter/foundation.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._createReviewUseCase, this._getDoctorReviewsUseCase)
    : super(ReviewInitial());

  final CreateReviewUseCase _createReviewUseCase;
  final GetDoctorReviewsUseCase _getDoctorReviewsUseCase;
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
        CreateReviewParams(
          doctorId: doctorId,
          rating: rating,
          comment: comment,
          isActive: true,
        ),
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
          unawaited(getDoctorReviews(doctorId));
        },
      );
    } catch (error) {
      if (isClosed || requestId != _requestId) return;
      emit(ReviewFailure(error.toString()));
    }
  }

  Future<void> getDoctorReviews(int doctorId) async {
    final requestId = ++_requestId;
    if (isClosed) return;

    emit(ReviewLoading());

    try {
      final result = await _getDoctorReviewsUseCase(
        GetDoctorReviewsParams(doctorId),
      );

      if (isClosed || requestId != _requestId) return;

      result.fold(
        (failure) {
          if (isClosed || requestId != _requestId) return;
          emit(ReviewFailure(failure.errorMessage));
        },
        (reviews) {
          if (isClosed || requestId != _requestId) return;
          emit(ReviewLoaded(reviews));
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
