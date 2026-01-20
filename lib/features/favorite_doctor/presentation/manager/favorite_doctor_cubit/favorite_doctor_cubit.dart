import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

part 'favorite_doctor_state.dart';

class FavoriteDoctorCubit extends Cubit<FavoriteDoctorState> {
  Query<Either<Failure, List<Doctor>>>? _favoriteDoctorsQuery;

  FavoriteDoctorCubit() : super(FavoriteDoctorInitial());

  Future<void> getFavoriteDoctors({bool forceRefresh = false}) async {
    _favoriteDoctorsQuery = favoriteDoctorsQuery();

    if (forceRefresh) {
      if (!isClosed) {
        final result = await _favoriteDoctorsQuery!.refetch();
        if (result.status == QueryStatus.success && result.data != null) {
          result.data!.fold(
            (failure) => emit(FavoriteDoctorsError(failure.errorMessage)),
            (doctors) {
              log('Refetched favorite doctors from API: ${doctors.length}');
              emit(FavoriteDoctorsLoaded(doctors));
            },
          );
        }
      }
      return;
    }

    final cachedData = _favoriteDoctorsQuery!.state.data;
    if (cachedData != null) {
      cachedData.fold(
        (failure) => emit(FavoriteDoctorsError(failure.errorMessage)),
        (doctors) {
          log('Loaded favorite doctors from cache: ${doctors.length}');
          emit(FavoriteDoctorsLoaded(doctors));
        },
      );

      _refetchIfStale();
      return;
    }

    emit(FavoirteDoctorsLoading());

    final queryState = await _favoriteDoctorsQuery!.result;
    final result = queryState.data;
    if (result == null) {
      emit(FavoriteDoctorsError('Failed to fetch favorite doctors'));
      return;
    }
    result.fold((failure) => emit(FavoriteDoctorsError(failure.errorMessage)), (
      doctors,
    ) {
      log('Fetched favorite doctors from API: ${doctors.length}');
      emit(FavoriteDoctorsLoaded(doctors));
    });
  }

  Future<void> _refetchIfStale() async {
    if (_favoriteDoctorsQuery == null) return;

    final state = _favoriteDoctorsQuery!.state;
    final isStale =
        state.status == QueryStatus.success &&
        DateTime.now().difference(state.timeCreated) >
            AppQueryConfig.defaultRefetchDuration;

    if (isStale) {
      log('Background refetch: favorite doctors data is stale');
      await _favoriteDoctorsQuery!.refetch();
      final result = _favoriteDoctorsQuery!.state.data;
      if (result != null && !isClosed) {
        result.fold((_) {}, (doctors) => emit(FavoriteDoctorsLoaded(doctors)));
      }
    }
  }

  void invalidateCache() {
    invalidateFavoriteDoctorsCache();
  }

  @override
  Future<void> close() {
    _favoriteDoctorsQuery = null;
    return super.close();
  }
}
