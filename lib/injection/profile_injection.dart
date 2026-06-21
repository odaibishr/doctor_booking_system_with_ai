import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/profile_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/profile_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/manager/profile/profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/usecases/create_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/use_cases/logout_use_case.dart';

class ProfileInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(),
    );

    sl.registerLazySingleton<ProfileRepo>(
      () => ProfileRepoImpl(
        sl<ProfileRemoteDataSource>(),
        sl<ProfileLocalDataSource>(),
        sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<CreateProfileUseCase>(
      () => CreateProfileUseCase(sl()),
    );

    sl.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(sl()),
    );

    sl.registerLazySingleton<ProfileCubit>(
      () => ProfileCubit(
        sl<CreateProfileUseCase>(),
        sl<GetProfileUseCase>(),
        sl<LogoutUseCase>(),
      ),
    );
  }
}
