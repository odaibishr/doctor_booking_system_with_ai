import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_my_reviews_use_case.dart';
import 'doctor_reviews_state.dart';

class DoctorReviewsCubit extends Cubit<DoctorReviewsState> {
  final GetMyReviewsUseCase _getMyReviewsUseCase;
  final ReviewRepo _reviewRepo;

  DoctorReviewsCubit(this._getMyReviewsUseCase, this._reviewRepo)
    : super(DoctorReviewsInitial());

  Future<void> fetchMyReviews() async {
    emit(DoctorReviewsLoading());
    final result = await _getMyReviewsUseCase();
    result.fold(
      (failure) => emit(DoctorReviewsError(failure.errorMessage)),
      (data) => emit(
        DoctorReviewsLoaded(
          reviews: data.reviews,
          avgRating: data.avgRating,
          totalCount: data.totalCount,
        ),
      ),
    );
  }

  Future<void> toggleReviewActive(int reviewId) async {
    final currentState = state;
    if (currentState is! DoctorReviewsLoaded) return;

    final updatedReviews = currentState.reviews.map((r) {
      if (r.id == reviewId) {
        return Review(
          id: r.id,
          doctorId: r.doctorId,
          userId: r.userId,
          comment: r.comment,
          rating: r.rating,
          user: r.user,
          isActive: !r.isActive,
        );
      }
      return r;
    }).toList();

    emit(
      DoctorReviewsLoaded(
        reviews: updatedReviews,
        avgRating: currentState.avgRating,
        totalCount: currentState.totalCount,
      ),
    );

    final result = await _reviewRepo.toggleReviewActive(reviewId);
    result.fold((failure) {
      emit(
        DoctorReviewsLoaded(
          reviews: currentState.reviews,
          avgRating: currentState.avgRating,
          totalCount: currentState.totalCount,
        ),
      );
    }, (_) {});
  }
}
