import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/create_review_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/manager/review/review_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

// Pure Dart Mocks to avoid complex dependency conflicts with external testing libraries
class MockCreateReviewUseCase implements CreateReviewUseCase {
  @override
  late ReviewRepo reviewRepo;

  Either<Failure, Review>? resultToReturn;
  int callCount = 0;
  CreateReviewParams? lastParams;

  @override
  Future<Either<Failure, Review>> call([CreateReviewParams? params]) async {
    callCount++;
    lastParams = params;
    return resultToReturn ?? Left(Failure('No mocked response'));
  }
}

class MockWatchDoctorReviewsUseCase implements WatchDoctorReviewsUseCase {
  @override
  late ReviewRepo reviewRepo;

  Stream<Either<Failure, List<Review>>>? streamToReturn;
  int callCount = 0;
  int? lastDoctorId;

  @override
  Stream<Either<Failure, List<Review>>> call(int doctorId) {
    callCount++;
    lastDoctorId = doctorId;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshDoctorReviewsUseCase implements RefreshDoctorReviewsUseCase {
  @override
  late ReviewRepo reviewRepo;

  Future<void>? futureToReturn;
  int callCount = 0;
  int? lastDoctorId;

  @override
  Future<void> call(int doctorId) async {
    callCount++;
    lastDoctorId = doctorId;
    return futureToReturn ?? Future.value();
  }
}

// Minimal stub for Review
class FakeReview implements Review {
  @override
  int id = 1;
  @override
  int doctorId = 10;
  @override
  int userId = 100;
  @override
  String comment = "Test Comment";
  @override
  int rating = 5;
  @override
  User? user;
  @override
  bool isActive = false;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockCreateReviewUseCase mockCreateReviewUseCase;
  late MockWatchDoctorReviewsUseCase mockWatchDoctorReviewsUseCase;
  late MockRefreshDoctorReviewsUseCase mockRefreshDoctorReviewsUseCase;
  late ReviewCubit reviewCubit;

  setUp(() {
    mockCreateReviewUseCase = MockCreateReviewUseCase();
    mockWatchDoctorReviewsUseCase = MockWatchDoctorReviewsUseCase();
    mockRefreshDoctorReviewsUseCase = MockRefreshDoctorReviewsUseCase();
    reviewCubit = ReviewCubit(
      createReviewUseCase: mockCreateReviewUseCase,
      watchDoctorReviewsUseCase: mockWatchDoctorReviewsUseCase,
      refreshDoctorReviewsUseCase: mockRefreshDoctorReviewsUseCase,
    );
  });

  tearDown(() {
    reviewCubit.close();
  });

  test('initial state should be ReviewInitial', () {
    expect(reviewCubit.state, isA<ReviewInitial>());
  });

  group('createReview', () {
    test('emits [ReviewSubmitting, ReviewSuccess] and calls getDoctorReviews on success', () async {
      final fakeReview = FakeReview();
      mockCreateReviewUseCase.resultToReturn = Right(fakeReview);
      mockWatchDoctorReviewsUseCase.streamToReturn = Stream.value(const Right([]));

      final states = <ReviewState>[];
      final subscription = reviewCubit.stream.listen(states.add);

      await reviewCubit.createReview(
        doctorId: 10,
        rating: 5,
        comment: "Great doctor!",
      );

      await Future.delayed(Duration.zero);

      expect(states.length, 4); // ReviewSubmitting, ReviewSuccess, ReviewLoading, ReviewLoaded (from getDoctorReviews)
      expect(states[0], isA<ReviewSubmitting>());
      expect(states[1], isA<ReviewSuccess>());
      expect(states[2], isA<ReviewLoading>());
      expect(states[3], isA<ReviewLoaded>());

      final successState = states[1] as ReviewSuccess;
      expect(successState.review, fakeReview);
      expect(mockCreateReviewUseCase.callCount, 1);
      expect(mockWatchDoctorReviewsUseCase.callCount, 1);

      await subscription.cancel();
    });

    test('emits [ReviewSubmitting, ReviewFailure] on failure', () async {
      mockCreateReviewUseCase.resultToReturn = Left(Failure('Submission failed'));

      final states = <ReviewState>[];
      final subscription = reviewCubit.stream.listen(states.add);

      await reviewCubit.createReview(
        doctorId: 10,
        rating: 5,
        comment: "Great doctor!",
      );

      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<ReviewSubmitting>());
      expect(states[1], isA<ReviewFailure>());

      final failureState = states[1] as ReviewFailure;
      expect(failureState.message, 'Submission failed');

      await subscription.cancel();
    });
  });

  group('getDoctorReviews (stream watching)', () {
    test('emits [ReviewLoading, ReviewLoaded] when stream yields reviews successfully', () async {
      final fakeReviews = [FakeReview()];
      mockWatchDoctorReviewsUseCase.streamToReturn = Stream.value(Right(fakeReviews));

      final states = <ReviewState>[];
      final subscription = reviewCubit.stream.listen(states.add);

      await reviewCubit.getDoctorReviews(10);
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<ReviewLoading>());
      expect(states[1], isA<ReviewLoaded>());

      final loadedState = states[1] as ReviewLoaded;
      expect(loadedState.reviews, fakeReviews);
      expect(mockWatchDoctorReviewsUseCase.callCount, 1);

      await subscription.cancel();
    });

    test('emits [ReviewLoading, ReviewFailure] when stream yields Failure', () async {
      mockWatchDoctorReviewsUseCase.streamToReturn = Stream.value(Left(Failure('Fetch failed')));

      final states = <ReviewState>[];
      final subscription = reviewCubit.stream.listen(states.add);

      await reviewCubit.getDoctorReviews(10);
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<ReviewLoading>());
      expect(states[1], isA<ReviewFailure>());

      final failureState = states[1] as ReviewFailure;
      expect(failureState.message, 'Fetch failed');

      await subscription.cancel();
    });

    test('getDoctorReviews forceRefresh calls refreshDoctorReviewsUseCase and does not emit watch states', () async {
      await reviewCubit.getDoctorReviews(10, forceRefresh: true);

      expect(mockRefreshDoctorReviewsUseCase.callCount, 1);
      expect(mockWatchDoctorReviewsUseCase.callCount, 0);
    });
  });
}
