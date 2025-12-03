import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/usecases/get_doctor_details_use_case.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  final GetDoctorDetailsUseCase getDoctorDetailsUseCase;
  DoctorDetailsCubit(this.getDoctorDetailsUseCase) : super(DoctorDetailsInitial());

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
