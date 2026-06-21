import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/repos/auth_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/repos/logout_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/google_sign_in_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/repos/logout_repo.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/use_cases/logout_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/services/google_sign_in_service.dart';

class AuthInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    );

    // Repository
    sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(
        authRemoteDataSource: sl(),
        authLocalDataSource: sl(),
        googleSignInService: sl(),
      ),
    );

    sl.registerLazySingleton<LogoutRepo>(
      () => LogoutRepoImpl(
        sl<AuthRemoteDataSource>(),
        sl<AuthLocalDataSource>(),
        sl<ProfileLocalDataSource>(),
        sl<GoogleSignInService>(),
      ),
    );

    // Use Cases
    sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(sl()),
    );
    sl.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(sl()),
    );
    sl.registerLazySingleton<CheckAuthStatusUsecase>(
      () => CheckAuthStatusUsecase(sl()),
    );
    sl.registerLazySingleton<GoogleSignInUseCase>(
      () => GoogleSignInUseCase(sl()),
    );
    sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(sl()),
    );

    // Cubit
    sl.registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        signInUseCase: sl(),
        signUpUsecase: sl(),
        checkAuthStatusUsecase: sl(),
        logoutUseCase: sl(),
        googleSignInUseCase: sl(),
        pusherService: sl(),
      ),
    );
  }
}
