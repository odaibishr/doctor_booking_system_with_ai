import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/manager/network/network_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/manager/theme/theme_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/appointment_refresh_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/fcm_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/google_sign_in_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_local_data_source.dart';

class CoreInjection {
  static Future<void> register(GetIt sl) async {
    // Must run first: opens all Hive boxes and registers adapters
    await HiveService.init();

    sl.registerLazySingleton(() => GoogleSignInService());


    sl.registerLazySingleton<HiveService>(() => HiveService());

    sl.registerLazySingleton<NotificationService>(
      () => NotificationService(AppRouter.navigatorKey),
    );

    sl.registerLazySingleton<PusherService>(
      () => PusherService(),
    );

    sl.registerLazySingleton<FcmService>(
      () => FcmService(sl()),
    );

    sl.registerLazySingleton<AppointmentRefreshService>(
      () => AppointmentRefreshService(
        sl<PusherService>(),
        sl<FcmService>(),
      ),
    );

    // Network
    sl.registerLazySingleton<Connectivity>(
      () => Connectivity(),
    );

    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<Connectivity>()),
    );

    // Auth local data source is needed by DioConsumer, registered here
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<HiveService>()),
    );

    sl.registerLazySingleton<DioConsumer>(
      () => DioConsumer(dio: Dio(), tokenStorage: sl<AuthLocalDataSource>()),
    );

    // Theme & Network Cubits
    sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

    sl.registerLazySingleton<NetworkCubit>(
      () => NetworkCubit(sl()),
    );
  }
}
