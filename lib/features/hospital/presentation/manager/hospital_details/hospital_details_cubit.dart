import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/domain/use_cases/get_hospital_details_use_case.dart';
import 'package:flutter/foundation.dart';

part 'hospital_details_state.dart';

class HospitalDetailsCubit extends Cubit<HospitalDetailsState> {
  final GetHospitalDetailsUseCase getHospitalDetailsUseCase;
  HospitalDetailsCubit(this.getHospitalDetailsUseCase)
    : super(HospitalDetailsInitial());

  Future<void> getHospitalDetails(int id) async {
    emit(HospitalDetailsLoading());
    try {
      final result = await getHospitalDetailsUseCase(
        GetHospitalDetailsParams(id),
      );

      result.fold(
        (failure) => emit(HospitalDetailsError(failure.errorMessage)),
        (hospital) => emit(HospitalDetailsLoaded(hospital)),
      );
    } catch (error) {
      emit(HospitalDetailsError(error.toString()));
    }
  }
}
