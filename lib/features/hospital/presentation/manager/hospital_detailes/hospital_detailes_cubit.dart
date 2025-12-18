import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/domain/use_cases/get_hostpital_details_use_cae.dart';
import 'package:flutter/foundation.dart';

part 'hospital_detailes_state.dart';

class HospitalDetailesCubit extends Cubit<HospitalDetailesState> {
  final GetHospitalDetailsUseCase getHospitalDetailsUseCase;
  HospitalDetailesCubit(this.getHospitalDetailsUseCase)
    : super(HospitalDetailesInitial());

  Future<void> getHospitalDetailes(int id) async {
    emit(HospitalDetailesLoading());
    try {
      final result = await getHospitalDetailsUseCase(
        GetHospitalDetailsParams(id),
      );

      result.fold(
        (failure) => emit(HospitalDetailesError(failure.errorMessage)),
        (hospital) => emit(HospitalDetailesLoaded(hospital)),
      );
    } catch (error) {
      emit(HospitalDetailesError(error.toString()));
    }
  }
}
