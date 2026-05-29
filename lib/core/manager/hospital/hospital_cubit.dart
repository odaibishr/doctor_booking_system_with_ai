import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_hospitals_use_case.dart';

part 'hospital_state.dart';

class HospitalCubit extends Cubit<HospitalState> {
  final WatchHospitalsUseCase watchHospitalsUseCase;
  final RefreshHospitalsUseCase refreshHospitalsUseCase;
  StreamSubscription<Either<Failure, List<Hospital>>>? _hospitalsSub;

  HospitalCubit({
    required this.watchHospitalsUseCase,
    required this.refreshHospitalsUseCase,
  }) : super(HospitalInitial());

  Future<void> getHospitals({bool forceRefresh = false}) async {
    if (forceRefresh) {
      await refreshHospitalsUseCase();
      return;
    }

    emit(HospitalLoading());
    _hospitalsSub?.cancel();
    _hospitalsSub = watchHospitalsUseCase().listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => emit(HospitalError(failure.errorMessage)),
            (hospitals) {
              log('Hospitals list state stream updated: ${hospitals.length}');
              emit(HospitalLoadded(hospitals));
            },
          );
        }
      },
      onError: (e) {
        if (!isClosed) {
          emit(HospitalError(e.toString()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _hospitalsSub?.cancel();
    return super.close();
  }
}
