import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctor_details_use_case.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  final WatchDoctorDetailsUseCase watchDoctorDetailsUseCase;
  final RefreshDoctorDetailsUseCase refreshDoctorDetailsUseCase;

  StreamSubscription<Either<Failure, Doctor>>? _doctorDetailsSub;
  int? _currentDoctorId;

  DoctorDetailsCubit({
    required this.watchDoctorDetailsUseCase,
    required this.refreshDoctorDetailsUseCase,
  }) : super(DoctorDetailsInitial());

  Future<void> getDoctorsDetails(int id, {bool forceRefresh = false}) async {
    _currentDoctorId = id;

    if (forceRefresh) {
      await refreshDoctorDetailsUseCase(id);
      return;
    }

    emit(DoctorDetailsLoading());
    _doctorDetailsSub?.cancel();
    _doctorDetailsSub = watchDoctorDetailsUseCase(id).listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => emit(DoctorDetailsError(message: failure.errorMessage)),
            (doctor) {
              log('Loaded doctor details from stream: ${doctor.name}');
              emit(DoctorDetailsLoaded(doctor: doctor));
            },
          );
        }
      },
      onError: (e) {
        if (!isClosed) {
          emit(DoctorDetailsError(message: e.toString()));
        }
      },
    );
  }

  void invalidateCache() {
    if (_currentDoctorId != null) {
      refreshDoctorDetailsUseCase(_currentDoctorId!);
    }
  }

  @override
  Future<void> close() {
    _doctorDetailsSub?.cancel();
    return super.close();
  }
}
