import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/hospital_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/manager/hospital/hospital_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/domain/use_cases/get_hospital_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/manager/hospital_details/hospital_details_cubit.dart';

class HospitalInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<HospitalRemoteDataSource>(
      () => HospitalRemoteDataSourceImpl(sl()),
    );

    final hospitalsBox = Hive.box<Hospital>(kHospitalBox);
    sl.registerLazySingleton<HospitalLocalDataSource>(
      () => HospitalLocalDataSourceImpl(hospitalsBox),
    );

    sl.registerLazySingleton<HospitalRepo>(
      () => HospitalRepoImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    // Use Cases
    sl.registerLazySingleton<GetHospitalsUseCase>(
      () => GetHospitalsUseCase(sl()),
    );
    sl.registerLazySingleton<WatchHospitalsUseCase>(
      () => WatchHospitalsUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshHospitalsUseCase>(
      () => RefreshHospitalsUseCase(sl()),
    );
    sl.registerLazySingleton<GetHospitalDetailsUseCase>(
      () => GetHospitalDetailsUseCase(sl()),
    );

    // Cubits
    sl.registerLazySingleton<HospitalCubit>(
      () => HospitalCubit(
        watchHospitalsUseCase: sl(),
        refreshHospitalsUseCase: sl(),
      ),
    );

    sl.registerFactory<HospitalDetailsCubit>(
      () => HospitalDetailsCubit(sl<GetHospitalDetailsUseCase>()),
    );
  }
}
