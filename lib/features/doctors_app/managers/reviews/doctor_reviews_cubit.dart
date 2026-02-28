import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_my_reviews_use_case.dart';
import 'doctor_reviews_state.dart';

class DoctorReviewsCubit extends Cubit<DoctorReviewsState> {
  final GetMyReviewsUseCase _getMyReviewsUseCase;

  DoctorReviewsCubit(this._getMyReviewsUseCase) : super(DoctorReviewsInitial());

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
}
