import 'package:get_it/get_it.dart';

/// FavoriteDoctor use cases and FavoriteDoctorCubit are registered in
/// HomeInjection because they share the same DoctorRepo dependencies.
/// This class is kept as a placeholder for future standalone favorite logic.
class FavoriteInjection {
  static void register(GetIt sl) {
    // No additional registrations needed —
    // GetFavoriteDoctorsUseCase, WatchFavoriteDoctorsUseCase,
    // RefreshFavoriteDoctorsUseCase, ToggleFavoriteDoctorUseCase,
    // FavoriteDoctorCubit, and ToggleFavoriteCubit are all
    // registered in HomeInjection.
  }
}
