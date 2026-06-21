import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/map/presentation/manager/map_bloc.dart';

class MapInjection {
  static void register(GetIt sl) {
    sl.registerFactory<MapBloc>(
      () => MapBloc(getDoctorsUseCase: sl<GetDoctorsUseCase>()),
    );
  }
}
