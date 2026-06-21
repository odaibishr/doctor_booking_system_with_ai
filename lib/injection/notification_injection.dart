import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/notification/data/repos/notification_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/notification/domain/repos/notification_repo.dart';
import 'package:doctor_booking_system_with_ai/features/notification/presentation/manager/notification_cubit.dart';

class NotificationInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<NotificationRepo>(
      () => NotificationRepoImpl(sl()),
    );

    sl.registerFactory<NotificationCubit>(
      () => NotificationCubit(sl()),
    );
  }
}
