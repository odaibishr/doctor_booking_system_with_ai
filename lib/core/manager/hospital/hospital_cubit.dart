import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:flutter/foundation.dart';

part 'hospital_state.dart';

class HospitalCubit extends Cubit<HospitalState> {
  Query<Either<Failure, List<Hospital>>>? _hospitalsQuery;

  HospitalCubit() : super(HospitalInitial());

  Future<void> getHospitals({bool forceRefresh = false}) async {
    _hospitalsQuery = hospitalsQuery();

    final cachedData = _hospitalsQuery!.state.data;
    if (cachedData != null && !forceRefresh) {
      cachedData.fold((failure) => emit(HospitalError(failure.errorMessage)), (
        hospitals,
      ) {
        log('Loaded hospitals from cache: ${hospitals.length}');
        emit(HospitalLoadded(hospitals));
      });

      _refetchIfStale();
      return;
    }

    emit(HospitalLoading());

    final queryState = await _hospitalsQuery!.result;
    final result = queryState.data;
    if (result == null) {
      emit(HospitalError('Failed to fetch hospitals'));
      return;
    }
    result.fold((failure) => emit(HospitalError(failure.errorMessage)), (
      hospitals,
    ) {
      log('Fetched hospitals from API: ${hospitals.length}');
      emit(HospitalLoadded(hospitals));
    });
  }

  Future<void> _refetchIfStale() async {
    if (_hospitalsQuery == null) return;

    final state = _hospitalsQuery!.state;
    final isStale =
        state.status == QueryStatus.success &&
        DateTime.now().difference(state.timeCreated) >
            AppQueryConfig.defaultRefetchDuration;

    if (isStale) {
      log('Background refetch: hospitals data is stale');
      await _hospitalsQuery!.refetch();
      final result = _hospitalsQuery!.state.data;
      if (result != null && !isClosed) {
        result.fold((_) {}, (hospitals) => emit(HospitalLoadded(hospitals)));
      }
    }
  }

  void invalidateCache() {
    invalidateHospitalsCache();
  }

  @override
  Future<void> close() {
    _hospitalsQuery = null;
    return super.close();
  }
}
