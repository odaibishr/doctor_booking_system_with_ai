import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/data/data_sources/appointment_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/data/repos/appointment_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/repos/appoinment_repo.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/use_cases/create_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/datasources/booking_history_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/datasources/booking_history_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/repos/booking_history_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/cancel_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/get_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/reschedule_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/watch_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/refresh_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/manager/booking_history_cubit/booking_history_cubit.dart';

class BookingInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<BookingHistoryRemoteDataSource>(
      () => BookingHistoryRemoteDataSourceImpl(sl()),
    );

    final bookingHistoryBox = Hive.box<Booking>(kBookingHistoryBox);
    sl.registerLazySingleton<BookingHistoryLocalDataSource>(
      () => BookingHistoryLocalDataSourceImpl(bookingHistoryBox),
    );

    sl.registerLazySingleton<BookingHistoryRepo>(
      () => BookingHistoryRepoImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<AppoinmentRepo>(
      () => AppointmentRepoImpl(remoteDataSource: sl()),
    );

    // Use Cases
    sl.registerLazySingleton<GetBookingHistoryUseCase>(
      () => GetBookingHistoryUseCase(sl()),
    );
    sl.registerLazySingleton<WatchBookingHistoryUseCase>(
      () => WatchBookingHistoryUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshBookingHistoryUseCase>(
      () => RefreshBookingHistoryUseCase(sl()),
    );
    sl.registerLazySingleton<CancelAppointmentUseCase>(
      () => CancelAppointmentUseCase(sl()),
    );
    sl.registerLazySingleton<RescheduleAppointmentUseCase>(
      () => RescheduleAppointmentUseCase(sl()),
    );
    sl.registerLazySingleton<CreateAppointmentUseCase>(
      () => CreateAppointmentUseCase(appoinmentRepo: sl()),
    );

    // Cubit
    sl.registerFactory<BookingHistoryCubit>(
      () => BookingHistoryCubit(
        cancelAppointmentUseCase: sl(),
        rescheduleAppointmentUseCase: sl(),
        watchBookingHistoryUseCase: sl(),
        refreshBookingHistoryUseCase: sl(),
        pusherService: sl<PusherService>(),
      ),
    );
  }
}
