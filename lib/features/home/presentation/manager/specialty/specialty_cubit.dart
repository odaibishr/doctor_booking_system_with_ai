// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/usecases/get_specilaties_use_case.dart';

part 'specialty_state.dart';

class SpecialtyCubit extends Cubit<SpecialtyState> {
  final GetSpecilatiesUseCase getSpecilatiesUseCase;
  SpecialtyCubit(this.getSpecilatiesUseCase) : super(SpecialtyInitial());

  Future<void> getSpecialties() async {
    emit(SpcialtyLoading());
    try {
      final result = await getSpecilatiesUseCase();
      result.fold(
        (failure) => emit(SpecialtyError(message: failure.errorMessage)),
        (specialties) => emit(SpecialtyLoaded(specialties: specialties)),
      );
    } catch (error) {
      emit(SpecialtyError(message: error.toString()));
    }
  }
}
