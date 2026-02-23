import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  Query<Either<Failure, List<Doctor>>>? _doctorsQuery;

  DoctorCubit() : super(DoctorInitial());

  Future<void> fetchDoctors({bool forceRefresh = false}) async {
    _doctorsQuery = doctorsQuery();

    if (forceRefresh) {
      if (!isClosed) {
        // Option A: Just refetch in background without clearing current state
        final result = await _doctorsQuery!.refetch();
        if (result.status == QueryStatus.success && result.data != null) {
          result.data!.fold(
            (failure) => emit(DoctorsError(message: failure.errorMessage)),
            (doctors) {
              log('Refetched doctors from API: ${doctors.length}');
              emit(DoctorsLoaded(doctors: doctors));
            },
          );
        }
      }
      return;
    }

    final cachedData = _doctorsQuery!.state.data;
    if (cachedData != null) {
      cachedData.fold(
        (failure) => emit(DoctorsError(message: failure.errorMessage)),
        (doctors) {
          log('Loaded doctors from cache: ${doctors.length}');
          emit(DoctorsLoaded(doctors: doctors));
        },
      );

      _refetchIfStale();
      return;
    }

    emit(DoctorsLoading());

    final queryState = await _doctorsQuery!.result;
    final result = queryState.data;
    if (result == null) {
      emit(DoctorsError(message: 'فشل في جلب قائمة الأطباء'));
      return;
    }
    result.fold(
      (failure) => emit(DoctorsError(message: failure.errorMessage)),
      (doctors) {
        log('Fetched doctors from API: ${doctors.length}');
        emit(DoctorsLoaded(doctors: doctors));
      },
    );
  }

  Future<void> _refetchIfStale() async {
    if (_doctorsQuery == null) return;

    final state = _doctorsQuery!.state;
    final isStale =
        state.status == QueryStatus.success &&
        DateTime.now().difference(state.timeCreated) >
            AppQueryConfig.defaultRefetchDuration;

    if (isStale) {
      log('Background refetch: doctors data is stale');
      await _doctorsQuery!.refetch();
      final result = _doctorsQuery!.state.data;
      if (result != null && !isClosed) {
        result.fold((_) {}, (doctors) => emit(DoctorsLoaded(doctors: doctors)));
      }
    }
  }

  void invalidateCache() {
    invalidateDoctorsCache();
  }

  @override
  Future<void> close() {
    _doctorsQuery = null;
    return super.close();
  }
}
