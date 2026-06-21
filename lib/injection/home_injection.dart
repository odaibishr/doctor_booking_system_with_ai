import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/doctor_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/doctor_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/specialty_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/specialty_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/doctor_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/specialty_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_all_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_all_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/toggle_favorite_doctor_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/presentation/manager/favorite_doctor_cubit/favorite_doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/get_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/watch_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/refresh_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor_details/doctor_details_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/toggle_favorite/toggle_favorite_cubit.dart';

class HomeInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<DoctorRemoteDataSource>(
      () => DoctorRemoteDataSourceImpl(sl()),
    );

    final doctorsBox = Hive.box<Doctor>(kDoctorBox);
    sl.registerLazySingleton<DoctorLocalDataSource>(
      () => DoctorLocalDataSourceImpl(doctorsBox),
    );

    sl.registerLazySingleton<SpecialtyRemoteDataSource>(
      () => SpecialtyRemoteDataSourceImpl(sl()),
    );

    final specialtyBox = Hive.box<Specialty>(kSpecialtyBox);
    sl.registerLazySingleton<SpecialtyLocalDataSource>(
      () => SpecialtyLocalDataSourceImpl(specialtyBox),
    );

    // Repos
    sl.registerLazySingleton<DoctorRepo>(
      () => DoctorRepoImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );

    sl.registerLazySingleton<SpecialtyRepo>(
      () => SpecialtyRepoImpl(sl(), sl(), sl()),
    );

    // Doctor Use Cases
    sl.registerLazySingleton<GetDoctorsUseCase>(() => GetDoctorsUseCase(sl()));
    sl.registerLazySingleton<WatchDoctorsUseCase>(
      () => WatchDoctorsUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshDoctorsUseCase>(
      () => RefreshDoctorsUseCase(sl()),
    );
    sl.registerLazySingleton<GetDoctorDetailsUseCase>(
      () => GetDoctorDetailsUseCase(sl()),
    );
    sl.registerLazySingleton<WatchDoctorDetailsUseCase>(
      () => WatchDoctorDetailsUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshDoctorDetailsUseCase>(
      () => RefreshDoctorDetailsUseCase(sl()),
    );

    // Specialty Use Cases
    sl.registerLazySingleton<GetSpecialtiesUseCase>(
      () => GetSpecialtiesUseCase(sl()),
    );
    sl.registerLazySingleton<WatchSpecialtiesUseCase>(
      () => WatchSpecialtiesUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshSpecialtiesUseCase>(
      () => RefreshSpecialtiesUseCase(sl()),
    );
    sl.registerLazySingleton<WatchAllSpecialtiesUseCase>(
      () => WatchAllSpecialtiesUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshAllSpecialtiesUseCase>(
      () => RefreshAllSpecialtiesUseCase(sl()),
    );

    // Favorite Use Cases
    sl.registerLazySingleton<ToggleFavoriteDoctorUseCase>(
      () => ToggleFavoriteDoctorUseCase(sl()),
    );
    sl.registerLazySingleton<GetFavoriteDoctorsUseCase>(
      () => GetFavoriteDoctorsUseCase(sl()),
    );
    sl.registerLazySingleton<WatchFavoriteDoctorsUseCase>(
      () => WatchFavoriteDoctorsUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshFavoriteDoctorsUseCase>(
      () => RefreshFavoriteDoctorsUseCase(sl()),
    );

    // Cubits
    sl.registerLazySingleton<DoctorCubit>(
      () => DoctorCubit(watchDoctorsUseCase: sl(), refreshDoctorsUseCase: sl()),
    );

    sl.registerLazySingleton<DoctorDetailsCubit>(
      () => DoctorDetailsCubit(
        watchDoctorDetailsUseCase: sl(),
        refreshDoctorDetailsUseCase: sl(),
      ),
    );

    sl.registerLazySingleton<SpecialtyCubit>(
      () => SpecialtyCubit(
        watchSpecialtiesUseCase: sl(),
        refreshSpecialtiesUseCase: sl(),
        watchAllSpecialtiesUseCase: sl(),
        refreshAllSpecialtiesUseCase: sl(),
      ),
    );

    sl.registerLazySingleton<FavoriteDoctorCubit>(
      () => FavoriteDoctorCubit(
        watchFavoriteDoctorsUseCase: sl(),
        refreshFavoriteDoctorsUseCase: sl(),
      ),
    );

    sl.registerLazySingleton<ToggleFavoriteCubit>(
      () => ToggleFavoriteCubit(
        sl(),
        sl<DoctorCubit>(),
        sl<FavoriteDoctorCubit>(),
        sl<DoctorDetailsCubit>(),
      ),
    );
  }
}
