// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/usecases/get_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/usecases/get_doctors_use_case.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final GetDoctorsUseCase getDoctorsUseCase;
  final GetDoctorDetailsUseCase getDoctorDetailsUseCase;
  DoctorCubit(this.getDoctorsUseCase, this.getDoctorDetailsUseCase)
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

  Future<void> getDoctorsDetails(int id) async {
    emit(DoctorDetailsLoading());
    try {
      final result = await getDoctorDetailsUseCase(
        GetDoctorDetailsUseCaseParams(id),
      );
      log('Fetched doctor details: $result');
      result.fold(
        (failure) => emit(DoctorDetailsError(message: failure.errorMessage)),
        (doctor) => emit(DoctorDetailsLoaded(doctor: doctor)),
      );
    } catch (error) {
      log('Error fetching doctor details: $error');
      emit(DoctorDetailsError(message: error.toString()));
    }
  }
}
