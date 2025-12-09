import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/get_favorite_doctors_use_case.dart';

part 'favorite_doctor_state.dart';

class FavoriteDoctorCubit extends Cubit<FavoriteDoctorState> {
  final GetFavoriteDoctorsUseCase getFavoriteDoctorsUseCase;
  FavoriteDoctorCubit(this.getFavoriteDoctorsUseCase)
    : super(FavoriteDoctorInitial());

  Future<void> getFavoriteDoctors() async {
    emit(FavoirteDoctorsLoading());
    try {
      final result = await getFavoriteDoctorsUseCase();

      result.fold(
        (failure) => emit(FavoriteDoctorsError(failure.errorMessage)),
        (doctors) => emit(FavoriteDoctorsLoaded(doctors)),
      );
    } catch (error) {
      emit(FavoriteDoctorsError(error.toString()));
    }
  }
}
