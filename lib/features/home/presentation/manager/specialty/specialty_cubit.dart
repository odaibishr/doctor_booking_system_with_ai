import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';

part 'specialty_state.dart';

class SpecialtyCubit extends Cubit<SpecialtyState> {
  Query<Either<Failure, List<Specialty>>>? _specialtiesQuery;

  SpecialtyCubit() : super(SpecialtyInitial());

  Future<void> getSpecialties({bool forceRefresh = false}) async {
    _specialtiesQuery = specialtiesQuery();

    final cachedData = _specialtiesQuery!.state.data;
    if (cachedData != null && !forceRefresh) {
      cachedData.fold(
        (failure) => emit(SpecialtyError(message: failure.errorMessage)),
        (specialties) {
          log('Loaded specialties from cache: ${specialties.length}');
          emit(SpecialtyLoaded(specialties: specialties));
        },
      );

      _refetchIfStale();
      return;
    }

    emit(SpcialtyLoading());

    final queryState = await _specialtiesQuery!.result;
    final result = queryState.data;
    if (result == null) {
      emit(SpecialtyError(message: 'Failed to fetch specialties'));
      return;
    }
    result.fold(
      (failure) => emit(SpecialtyError(message: failure.errorMessage)),
      (specialties) {
        log('Fetched specialties from API: ${specialties.length}');
        emit(SpecialtyLoaded(specialties: specialties));
      },
    );
  }

  Future<void> _refetchIfStale() async {
    if (_specialtiesQuery == null) return;

    final state = _specialtiesQuery!.state;
    final isStale =
        state.status == QueryStatus.success &&
        DateTime.now().difference(state.timeCreated) >
            AppQueryConfig.defaultRefetchDuration;

    if (isStale) {
      log('Background refetch: specialties data is stale');
      await _specialtiesQuery!.refetch();
      final result = _specialtiesQuery!.state.data;
      if (result != null && !isClosed) {
        result.fold(
          (_) {},
          (specialties) => emit(SpecialtyLoaded(specialties: specialties)),
        );
      }
    }
  }

  void invalidateCache() {
    invalidateSpecialtiesCache();
  }

  @override
  Future<void> close() {
    _specialtiesQuery = null;
    return super.close();
  }
}
