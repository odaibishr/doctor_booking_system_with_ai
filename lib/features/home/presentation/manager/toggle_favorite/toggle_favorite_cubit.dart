import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/toggle_favorite_doctor_use_case.dart';
import 'package:meta/meta.dart';

part 'toggle_favorite_state.dart';

class ToggleFavoriteCubit extends Cubit<ToggleFavoriteState> {
  final ToggleFavoriteDoctorUseCase toggleFavoriteDoctorUseCase;
  ToggleFavoriteCubit(this.toggleFavoriteDoctorUseCase)
    : super(ToggleFavoriteInitial());

  Future<void> toggleFavoriteDoctor(int doctorId) async {
    emit(ToggleFavoriteLoading());
    final result = await toggleFavoriteDoctorUseCase.call(
      ToggleFavoriteDoctorUseCaseParams(doctorId),
    );
    result.fold(
      (l) => emit(ToggleFavoriteError()),
      (r) => emit(ToggleFavoriteSuccess()),
    );
  }
}
