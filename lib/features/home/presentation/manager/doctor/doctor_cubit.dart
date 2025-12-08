// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final GetDoctorsUseCase getDoctorsUseCase;
  DoctorCubit(this.getDoctorsUseCase,)
    : super(DoctorInitial());

  Future<void> fetchDoctors() async {
    emit(DoctorsLoading());
    try {
      final result = await getDoctorsUseCase();
      log('Fetched doctors: $result');
      result.fold(
        (failure) => emit(DoctorsError(message: failure.errorMessage)),
        (doctors) => emit(DoctorsLoaded(doctors: doctors)),
      );
    } catch (error) {
      log('Error fetching doctors: $error');
      emit(DoctorsError(message: error.toString()));
    }
  }
}
