import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctors_use_case.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final WatchDoctorsUseCase watchDoctorsUseCase;
  final RefreshDoctorsUseCase refreshDoctorsUseCase;
  StreamSubscription<Either<Failure, List<Doctor>>>? _doctorsSub;

  DoctorCubit({
    required this.watchDoctorsUseCase,
    required this.refreshDoctorsUseCase,
  }) : super(DoctorInitial());

  Future<void> fetchDoctors({bool forceRefresh = false}) async {
    if (forceRefresh) {
      await refreshDoctorsUseCase();
      return;
    }

    emit(DoctorsLoading());
    _doctorsSub?.cancel();
    _doctorsSub = watchDoctorsUseCase().listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => emit(DoctorsError(message: failure.errorMessage)),
            (doctors) {
              log('Doctors list state stream updated: ${doctors.length}');
              emit(DoctorsLoaded(doctors: doctors));
            },
          );
        }
      },
      onError: (e) {
        if (!isClosed) {
          emit(DoctorsError(message: e.toString()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _doctorsSub?.cancel();
    return super.close();
  }
}
