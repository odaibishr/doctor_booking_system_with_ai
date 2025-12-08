// core/service_locator.dart
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/toggle_favorite_doctor_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/data/datasources/profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/data/repos/profile_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/repos/profile_repo.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/usecases/create_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presention/manager/profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/doctor_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/doctor_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/specialty_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/specilaty_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/doctor_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/specialty_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_specilaties_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favoratie_doctor/domain/use_cases/get_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favoratie_doctor/presention/manager/favorite_doctor_cubit/favorite_doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor_details/doctor_details_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/toggle_favorite/toggle_favorite_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/search/domain/usecases/search_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/manager/search_doctors_bloc/search_doctors_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/repos/auth_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/check_auth_satus_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // Hive Initialization
  await HiveService.init();

  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());

  // Network
  serviceLocator.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator<DataConnectionChecker>()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(serviceLocator<HiveService>()),
  );

  serviceLocator.registerLazySingleton<DioConsumer>(
    () => DioConsumer(dio: Dio(), authLocalDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(serviceLocator()),
  );

  final doctorsBox = Hive.box<Doctor>(kDoctorBox);
  serviceLocator.registerLazySingleton<DoctorLocalDataSource>(
    () => DoctorLocalDataSourceImpl(doctorsBox),
  );

  serviceLocator.registerLazySingleton<SpecilatyRemoteDataSource>(
    () => SpecilatyRemoteDataSourceImpl(serviceLocator()),
  );

  final specialtyBox = Hive.box<Specialty>(kSpecialtyBox);
  serviceLocator.registerLazySingleton<SpecialtyLocalDataSource>(
    () => SpecialtyLocalDataSourceImpl(specialtyBox),
  );

  // Repository
  serviceLocator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      authRemoteDataSource: serviceLocator(),
      authLocalDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(serviceLocator<ProfileRemoteDataSource>()),
  );

  serviceLocator.registerLazySingleton<DoctorRepo>(
    () => DoctorRepoImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<SpecialtyRepo>(
    () =>
        SpecialtyRepoImpl(serviceLocator(), serviceLocator(), serviceLocator()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CheckAuthSatusUsecase>(
    () => CheckAuthSatusUsecase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<CreateProfileUseCase>(
    () => CreateProfileUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetDoctorsUseCase>(
    () => GetDoctorsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetSpecilatiesUseCase>(
    () => GetSpecilatiesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetDoctorDetailsUseCase>(
    () => GetDoctorDetailsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<SearchDoctorsUseCase>(
    () => SearchDoctorsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ToggleFavoriteDoctorUseCase>(
    () => ToggleFavoriteDoctorUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetFavoriteDoctorsUseCase>(
    () => GetFavoriteDoctorsUseCase(serviceLocator()),
  );

  // Cubit
  serviceLocator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      signInUseCase: serviceLocator(),
      signUpUsecase: serviceLocator(),
      checkAuthSatusUsecase: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<DoctorCubit>(
    () => DoctorCubit(serviceLocator<GetDoctorsUseCase>()),
  );

  serviceLocator.registerLazySingleton<DoctorDetailsCubit>(
    () => DoctorDetailsCubit(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<SpecialtyCubit>(
    () => SpecialtyCubit(serviceLocator<GetSpecilatiesUseCase>()),
  );

  serviceLocator.registerLazySingleton<SearchDoctorsBloc>(
    () => SearchDoctorsBloc(
      serviceLocator<SearchDoctorsUseCase>(),
      serviceLocator<GetDoctorsUseCase>(),
    ),
  );

  serviceLocator.registerLazySingleton<ToggleFavoriteCubit>(
    () => ToggleFavoriteCubit(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<FavoriteDoctorCubit>(
    () => FavoriteDoctorCubit(serviceLocator<GetFavoriteDoctorsUseCase>()),
  );
}
