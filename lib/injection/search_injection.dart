import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/features/search/domain/usecases/search_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/manager/search_doctors_cubit/search_doctors_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';

class SearchInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<SearchDoctorsUseCase>(
      () => SearchDoctorsUseCase(sl()),
    );

    sl.registerFactory<SearchDoctorsCubit>(
      () => SearchDoctorsCubit(
        sl<SearchDoctorsUseCase>(),
        sl<GetDoctorsUseCase>(),
      ),
    );
  }
}
