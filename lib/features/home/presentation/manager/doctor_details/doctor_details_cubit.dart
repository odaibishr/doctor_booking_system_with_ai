import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  Query<Either<Failure, Doctor>>? _doctorDetailsQuery;
  int? _currentDoctorId;

  DoctorDetailsCubit() : super(DoctorDetailsInitial());

  Future<void> getDoctorsDetails(int id, {bool forceRefresh = false}) async {
    _currentDoctorId = id;
    _doctorDetailsQuery = doctorDetailsQuery(id);

    final cachedData = _doctorDetailsQuery!.state.data;
    if (cachedData != null && !forceRefresh) {
      cachedData.fold(
        (failure) => emit(DoctorDetailsError(message: failure.errorMessage)),
        (doctor) {
          log('Loaded doctor details from cache: ${doctor.name}');
          emit(DoctorDetailsLoaded(doctor: doctor));
        },
      );

      _refetchIfStale();
      return;
    }

    emit(DoctorDetailsLoading());

    final queryState = await _doctorDetailsQuery!.result;
    final result = queryState.data;
    if (result == null) {
      emit(DoctorDetailsError(message: 'Failed to fetch doctor details'));
      return;
    }
    result.fold(
      (failure) => emit(DoctorDetailsError(message: failure.errorMessage)),
      (doctor) {
        log('Fetched doctor details from API: ${doctor.name}');
        emit(DoctorDetailsLoaded(doctor: doctor));
      },
    );
  }

  Future<void> _refetchIfStale() async {
    if (_doctorDetailsQuery == null) return;

    final state = _doctorDetailsQuery!.state;
    final isStale =
        state.status == QueryStatus.success &&
        DateTime.now().difference(state.timeCreated) >
            AppQueryConfig.defaultRefetchDuration;

    if (isStale) {
      log('Background refetch: doctor details data is stale');
      await _doctorDetailsQuery!.refetch();
      final result = _doctorDetailsQuery!.state.data;
      if (result != null && !isClosed) {
        result.fold(
          (_) {},
          (doctor) => emit(DoctorDetailsLoaded(doctor: doctor)),
        );
      }
    }
  }

  void invalidateCache() {
    if (_currentDoctorId != null) {
      invalidateDoctorDetailsCache(_currentDoctorId!);
    }
  }

  @override
  Future<void> close() {
    _doctorDetailsQuery = null;
    return super.close();
  }
}
