import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/watch_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/refresh_favorite_doctors_use_case.dart';

part 'favorite_doctor_state.dart';

class FavoriteDoctorCubit extends Cubit<FavoriteDoctorState> {
  final WatchFavoriteDoctorsUseCase watchFavoriteDoctorsUseCase;
  final RefreshFavoriteDoctorsUseCase refreshFavoriteDoctorsUseCase;

  StreamSubscription<Either<Failure, List<Doctor>>>? _favoriteDoctorsSub;

  FavoriteDoctorCubit({
    required this.watchFavoriteDoctorsUseCase,
    required this.refreshFavoriteDoctorsUseCase,
  }) : super(FavoriteDoctorInitial());

  Future<void> getFavoriteDoctors({bool forceRefresh = false}) async {
    if (forceRefresh) {
      await refreshFavoriteDoctorsUseCase();
      return;
    }

    emit(FavoirteDoctorsLoading());
    _favoriteDoctorsSub?.cancel();
    _favoriteDoctorsSub = watchFavoriteDoctorsUseCase().listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => emit(FavoriteDoctorsError(failure.errorMessage)),
            (doctors) {
              log('Loaded favorite doctors from stream: ${doctors.length}');
              emit(FavoriteDoctorsLoaded(doctors));
            },
          );
        }
      },
      onError: (e) {
        if (!isClosed) {
          emit(FavoriteDoctorsError(e.toString()));
        }
      },
    );
  }

  void invalidateCache() {
    refreshFavoriteDoctorsUseCase();
  }

  @override
  Future<void> close() {
    _favoriteDoctorsSub?.cancel();
    return super.close();
  }
}
