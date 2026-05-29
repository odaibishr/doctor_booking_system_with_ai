import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/create_review_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctor_reviews_use_case.dart';
import 'package:flutter/foundation.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit({
    required CreateReviewUseCase createReviewUseCase,
    required this.watchDoctorReviewsUseCase,
    required this.refreshDoctorReviewsUseCase,
  }) : _createReviewUseCase = createReviewUseCase,
       super(ReviewInitial());

  final CreateReviewUseCase _createReviewUseCase;
  final WatchDoctorReviewsUseCase watchDoctorReviewsUseCase;
  final RefreshDoctorReviewsUseCase refreshDoctorReviewsUseCase;

  StreamSubscription<Either<Failure, List<Review>>>? _reviewsSub;
  int? _currentDoctorId;

  Future<void> createReview({
    required int doctorId,
    required int rating,
    required String comment,
  }) async {
    if (isClosed) return;

    emit(ReviewSubmitting());

    try {
      final result = await _createReviewUseCase(
        CreateReviewParams(
          doctorId: doctorId,
          rating: rating,
          comment: comment,
          isActive: false,
        ),
      );

      if (isClosed) return;

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(ReviewFailure(failure.errorMessage));
        },
        (review) {
          if (isClosed) return;
          emit(ReviewSuccess(review));
          unawaited(getDoctorReviews(doctorId));
        },
      );
    } catch (error) {
      if (isClosed) return;
      emit(ReviewFailure(error.toString()));
    }
  }

  Future<void> getDoctorReviews(
    int doctorId, {
    bool forceRefresh = false,
  }) async {
    if (isClosed) return;

    _currentDoctorId = doctorId;

    if (forceRefresh) {
      await refreshDoctorReviewsUseCase(doctorId);
      return;
    }

    emit(ReviewLoading());
    _reviewsSub?.cancel();
    _reviewsSub = watchDoctorReviewsUseCase(doctorId).listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => emit(ReviewFailure(failure.errorMessage)),
            (reviews) {
              log('Loaded reviews from stream: ${reviews.length}');
              emit(ReviewLoaded(reviews));
            },
          );
        }
      },
      onError: (e) {
        if (!isClosed) {
          emit(ReviewFailure(e.toString()));
        }
      },
    );
  }

  void invalidateCache() {
    if (_currentDoctorId != null) {
      refreshDoctorReviewsUseCase(_currentDoctorId!);
    }
  }

  @override
  Future<void> close() {
    _reviewsSub?.cancel();
    return super.close();
  }
}
