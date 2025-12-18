import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/toggle_favorite_doctor_use_case.dart';
import 'package:flutter/foundation.dart';

part 'toggle_favorite_state.dart';

class ToggleFavoriteCubit extends Cubit<ToggleFavoriteState> {
  final ToggleFavoriteDoctorUseCase toggleFavoriteDoctorUseCase;
  ToggleFavoriteCubit(this.toggleFavoriteDoctorUseCase)
    : super(ToggleFavoriteInitial());

  Future<void> toggleFavoriteDoctor(
    int doctorId, {
    required bool currentFavorite,
  }) async {
    emit(ToggleFavoriteLoading());
    try {
      final result = await toggleFavoriteDoctorUseCase.call(
        ToggleFavoriteDoctorUseCaseParams(doctorId),
      );
      result.fold(
        (failure) => emit(
          ToggleFavoriteError(message: failure.errorMessage),
        ),
        (_) => emit(
          ToggleFavoriteSuccess(isFavorite: !currentFavorite),
        ),
      );
    } catch (error) {
      emit(ToggleFavoriteError(message: error.toString()));
    }
  }
}
