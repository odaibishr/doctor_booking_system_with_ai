import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_hospitals_use_case.dart';
import 'package:meta/meta.dart';

part 'hospital_state.dart';

class HospitalCubit extends Cubit<HospitalState> {
  final GetHospitalsUseCase getHospitalsUseCase;
  HospitalCubit(this.getHospitalsUseCase) : super(HospitalInitial());

  Future<void> getHospitals() async {
    emit(HospitalLoading());
    try {
      final result = await getHospitalsUseCase();

      result.fold(
        (failure) => emit(HospitalError(failure.errorMessage)),
        (hospitals) => emit(HospitalLoadded(hospitals)),
      );
    } catch (error) {
      emit(HospitalError(error.toString()));
    }
  }
}
