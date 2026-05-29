import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_all_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_all_specialties_use_case.dart';

part 'specialty_state.dart';

class SpecialtyCubit extends Cubit<SpecialtyState> {
  final WatchSpecialtiesUseCase watchSpecialtiesUseCase;
  final RefreshSpecialtiesUseCase refreshSpecialtiesUseCase;
  final WatchAllSpecialtiesUseCase watchAllSpecialtiesUseCase;
  final RefreshAllSpecialtiesUseCase refreshAllSpecialtiesUseCase;

  StreamSubscription<Either<Failure, List<Specialty>>>? _specialtiesSub;
  StreamSubscription<Either<Failure, List<Specialty>>>? _allSpecialtiesSub;

  SpecialtyCubit({
    required this.watchSpecialtiesUseCase,
    required this.refreshSpecialtiesUseCase,
    required this.watchAllSpecialtiesUseCase,
    required this.refreshAllSpecialtiesUseCase,
  }) : super(SpecialtyInitial());

  Future<void> getSpecialties({bool forceRefresh = false}) async {
    if (forceRefresh) {
      await refreshSpecialtiesUseCase();
      return;
    }

    emit(SpecialtyLoading());
    _specialtiesSub?.cancel();
    _specialtiesSub = watchSpecialtiesUseCase().listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => emit(SpecialtyError(message: failure.errorMessage)),
            (specialties) {
              log('Loaded specialties from stream: ${specialties.length}');
              emit(SpecialtyLoaded(specialties: specialties));
            },
          );
        }
      },
      onError: (e) {
        if (!isClosed) {
          emit(SpecialtyError(message: e.toString()));
        }
      },
    );
  }

  Future<void> getAllSpecialties({bool forceRefresh = false}) async {
    if (forceRefresh) {
      await refreshAllSpecialtiesUseCase();
      return;
    }

    emit(SpecialtyLoading());
    _allSpecialtiesSub?.cancel();
    _allSpecialtiesSub = watchAllSpecialtiesUseCase().listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => emit(SpecialtyError(message: failure.errorMessage)),
            (specialties) {
              log('Loaded all specialties from stream: ${specialties.length}');
              emit(SpecialtyLoaded(specialties: specialties));
            },
          );
        }
      },
      onError: (e) {
        if (!isClosed) {
          emit(SpecialtyError(message: e.toString()));
        }
      },
    );
  }

  void invalidateCache() {
    refreshSpecialtiesUseCase();
    refreshAllSpecialtiesUseCase();
  }

  @override
  Future<void> close() {
    _specialtiesSub?.cancel();
    _allSpecialtiesSub?.cancel();
    return super.close();
  }
}
