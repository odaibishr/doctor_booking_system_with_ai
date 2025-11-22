// core/service_locator.dart
import 'package:dio/dio.dart';
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

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // Hive Initialization
  await HiveService.init();
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());

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

  // Repository
  serviceLocator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      authRemoteDataSource: serviceLocator(),
      authLocalDataSource: serviceLocator(),
    ),
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

  // Cubit
  serviceLocator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      signInUseCase: serviceLocator(),
      signUpUsecase: serviceLocator(),
      checkAuthSatusUsecase: serviceLocator(),
    ),
  );
}
