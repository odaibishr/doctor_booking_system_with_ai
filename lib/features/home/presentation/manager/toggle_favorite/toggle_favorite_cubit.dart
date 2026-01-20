import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/toggle_favorite_doctor_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/presentation/manager/favorite_doctor_cubit/favorite_doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:flutter/foundation.dart';

part 'toggle_favorite_state.dart';

class ToggleFavoriteCubit extends Cubit<ToggleFavoriteState> {
  final ToggleFavoriteDoctorUseCase toggleFavoriteDoctorUseCase;
  final DoctorCubit doctorCubit;
  final FavoriteDoctorCubit favoriteDoctorCubit;

  ToggleFavoriteCubit(
    this.toggleFavoriteDoctorUseCase,
    this.doctorCubit,
    this.favoriteDoctorCubit,
  ) : super(ToggleFavoriteInitial());

  Future<void> toggleFavoriteDoctor(
    int doctorId, {
    required bool currentFavorite,
  }) async {
    emit(ToggleFavoriteLoading());
    final result = await toggleFavoriteDoctorUseCase.call(
      ToggleFavoriteDoctorUseCaseParams(doctorId),
    );
    result.fold(
      (failure) => emit(ToggleFavoriteError(message: failure.errorMessage)),
      (_) {
        invalidateDoctorsCache();
        invalidateFavoriteDoctorsCache();
        invalidateDoctorDetailsCache(doctorId);

        doctorCubit.fetchDoctors(forceRefresh: true);
        favoriteDoctorCubit.getFavoriteDoctors(forceRefresh: true);

        emit(ToggleFavoriteSuccess(isFavorite: !currentFavorite));
      },
    );
  }
}
