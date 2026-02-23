import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/create_review_use_case.dart';
import 'package:flutter/foundation.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._createReviewUseCase) : super(ReviewInitial());

  final CreateReviewUseCase _createReviewUseCase;
  Query<Either<Failure, List<Review>>>? _reviewsQuery;
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

  Future<void> getDoctorReviews(
    int doctorId, {
    bool forceRefresh = false,
  }) async {
    if (isClosed) return;

    _currentDoctorId = doctorId;
    _reviewsQuery = doctorReviewsQuery(doctorId);

    final cachedData = _reviewsQuery!.state.data;
    if (cachedData != null && !forceRefresh) {
      cachedData.fold((failure) => emit(ReviewFailure(failure.errorMessage)), (
        reviews,
      ) {
        log('Loaded reviews from cache: ${reviews.length}');
        emit(ReviewLoaded(reviews));
      });

      _refetchIfStale(doctorId);
      return;
    }

    emit(ReviewLoading());

    final queryState = await _reviewsQuery!.result;
    final result = queryState.data;
    if (result == null) {
      emit(ReviewFailure('Failed to fetch reviews'));
      return;
    }
    result.fold((failure) => emit(ReviewFailure(failure.errorMessage)), (
      reviews,
    ) {
      log('Fetched reviews from API: ${reviews.length}');
      emit(ReviewLoaded(reviews));
    });
  }

  Future<void> _refetchIfStale(int doctorId) async {
    if (_reviewsQuery == null) return;

    final state = _reviewsQuery!.state;
    final isStale =
        state.status == QueryStatus.success &&
        DateTime.now().difference(state.timeCreated) >
            AppQueryConfig.defaultRefetchDuration;

    if (isStale) {
      log('Background refetch: reviews data is stale');
      await _reviewsQuery!.refetch();
      final result = _reviewsQuery!.state.data;
      if (result != null && !isClosed) {
        result.fold((_) {}, (reviews) => emit(ReviewLoaded(reviews)));
      }
    }
  }

  void invalidateCache() {
    if (_currentDoctorId != null) {
      invalidateDoctorReviewsCache(_currentDoctorId!);
    }
  }

  @override
  Future<void> close() {
    _reviewsQuery = null;
    return super.close();
  }
}
