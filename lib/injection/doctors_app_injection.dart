import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_my_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/services/fcm_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_appointment_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_appointment_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_dashboard_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_dashboard_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/repos/doctor_appointment_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/repos/doctor_dashboard_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/repos/doctor_profile_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_dashboard_repo.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/create_day_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/delete_day_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_appointment_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_dashboard_stats_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_days_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_my_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_schedules_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_appointments_by_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_dashboard_stats_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_appointment_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_profile_image_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_schedule_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_appointments_by_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_dashboard_stats_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/appointments/doctor_appointments_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/dashboard/doctor_dashboard_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/profile/doctor_profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/profile/doctor_schedule_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/reviews/doctor_reviews_cubit.dart';

class DoctorsAppInjection {
  static void register(GetIt sl) {
    // Data Sources
    sl.registerLazySingleton<DoctorDashboardRemoteDataSource>(
      () => DoctorDashboardRemoteDataSourceImpl(sl()),
    );

    final dashboardBox = Hive.box<DashboardStats>(kDashboardBox);
    sl.registerLazySingleton<DoctorDashboardLocalDataSource>(
      () => DoctorDashboardLocalDataSourceImpl(box: dashboardBox),
    );

    sl.registerLazySingleton<DoctorAppointmentRemoteDataSource>(
      () => DoctorAppointmentRemoteDataSourceImpl(sl()),
    );

    final appointmentBox = Hive.box<List<DoctorAppointment>>(kDoctorAppointmentBox);
    sl.registerLazySingleton<DoctorAppointmentLocalDataSource>(
      () => DoctorAppointmentLocalDataSourceImpl(appointmentBox),
    );

    sl.registerLazySingleton<DoctorProfileRemoteDataSource>(
      () => DoctorProfileRemoteDataSourceImpl(sl()),
    );

    final doctorProfileBox = Hive.box<Doctor>(kProfileBox);
    final doctorSchedulesBox = Hive.box<List<DoctorSchedule>>(kDoctorMySchedulesBox);
    final doctorDaysOffBox = Hive.box<List<DoctorDayOff>>(kDoctorDaysOffBox);

    sl.registerLazySingleton<DoctorProfileLocalDataSource>(
      () => DoctorProfileLocalDataSourceImpl(
        profileBox: doctorProfileBox,
        schedulesBox: doctorSchedulesBox,
        daysOffBox: doctorDaysOffBox,
      ),
    );

    // Repositories
    sl.registerLazySingleton<DoctorDashboardRepo>(
      () => DoctorDashboardRepoImpl(
        sl(),
        sl(),
        sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<DoctorAppointmentRepo>(
      () => DoctorAppointmentRepoImpl(
        sl(),
        sl(),
        sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<DoctorProfileRepo>(
      () => DoctorProfileRepoImpl(
        sl(),
        sl(),
        sl<NetworkInfo>(),
      ),
    );

    // Use Cases - Dashboard
    sl.registerLazySingleton<GetDashboardStatsUseCase>(
      () => GetDashboardStatsUseCase(sl()),
    );
    sl.registerLazySingleton<WatchDashboardStatsUseCase>(
      () => WatchDashboardStatsUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshDashboardStatsUseCase>(
      () => RefreshDashboardStatsUseCase(sl()),
    );

    // Use Cases - Appointments
    sl.registerLazySingleton<GetTodayAppointmentsUseCase>(
      () => GetTodayAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<GetUpcomingAppointmentsUseCase>(
      () => GetUpcomingAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<GetHistoryAppointmentsUseCase>(
      () => GetHistoryAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<UpdateAppointmentStatusUseCase>(
      () => UpdateAppointmentStatusUseCase(sl()),
    );
    sl.registerLazySingleton<GetAppointmentDetailsUseCase>(
      () => GetAppointmentDetailsUseCase(sl()),
    );
    sl.registerLazySingleton<GetAppointmentsUseCase>(
      () => GetAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<WatchTodayAppointmentsUseCase>(
      () => WatchTodayAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshTodayAppointmentsUseCase>(
      () => RefreshTodayAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<WatchUpcomingAppointmentsUseCase>(
      () => WatchUpcomingAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshUpcomingAppointmentsUseCase>(
      () => RefreshUpcomingAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<WatchHistoryAppointmentsUseCase>(
      () => WatchHistoryAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshHistoryAppointmentsUseCase>(
      () => RefreshHistoryAppointmentsUseCase(sl()),
    );
    sl.registerLazySingleton<WatchAppointmentsByStatusUseCase>(
      () => WatchAppointmentsByStatusUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshAppointmentsByStatusUseCase>(
      () => RefreshAppointmentsByStatusUseCase(sl()),
    );

    // Use Cases - Profile & Schedule
    sl.registerLazySingleton<GetMyProfileUseCase>(
      () => GetMyProfileUseCase(sl()),
    );
    sl.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(sl()),
    );
    sl.registerLazySingleton<UpdateProfileImageUseCase>(
      () => UpdateProfileImageUseCase(sl()),
    );
    sl.registerLazySingleton<GetSchedulesUseCase>(
      () => GetSchedulesUseCase(sl()),
    );
    sl.registerLazySingleton<UpdateScheduleUseCase>(
      () => UpdateScheduleUseCase(sl()),
    );
    sl.registerLazySingleton<GetDaysOffUseCase>(
      () => GetDaysOffUseCase(sl()),
    );
    sl.registerLazySingleton<CreateDayOffUseCase>(
      () => CreateDayOffUseCase(sl()),
    );
    sl.registerLazySingleton<DeleteDayOffUseCase>(
      () => DeleteDayOffUseCase(sl()),
    );

    // Cubits
    sl.registerFactory<DoctorDashboardCubit>(
      () => DoctorDashboardCubit(
        watchDashboardStatsUseCase: sl(),
        refreshDashboardStatsUseCase: sl(),
        pusherService: sl<PusherService>(),
        fcmService: sl<FcmService>(),
      ),
    );

    sl.registerFactory<DoctorAppointmentsCubit>(
      () => DoctorAppointmentsCubit(
        updateAppointmentStatusUseCase: sl(),
        watchTodayAppointmentsUseCase: sl(),
        refreshTodayAppointmentsUseCase: sl(),
        watchUpcomingAppointmentsUseCase: sl(),
        refreshUpcomingAppointmentsUseCase: sl(),
        watchHistoryAppointmentsUseCase: sl(),
        refreshHistoryAppointmentsUseCase: sl(),
        watchAppointmentsByStatusUseCase: sl(),
        refreshAppointmentsByStatusUseCase: sl(),
        pusherService: sl<PusherService>(),
        fcmService: sl<FcmService>(),
      ),
    );

    // DoctorReviewsCubit takes (GetMyReviewsUseCase, ReviewRepo)
    sl.registerFactory<DoctorReviewsCubit>(
      () => DoctorReviewsCubit(sl<GetMyReviewsUseCase>(), sl<ReviewRepo>()),
    );

    sl.registerFactory<DoctorProfileCubit>(
      () => DoctorProfileCubit(
        getMyProfileUseCase: sl(),
        updateProfileUseCase: sl(),
        updateProfileImageUseCase: sl(),
      ),
    );

    sl.registerFactory<DoctorScheduleCubit>(
      () => DoctorScheduleCubit(
        getSchedulesUseCase: sl(),
        updateScheduleUseCase: sl(),
        getDaysOffUseCase: sl(),
        createDayOffUseCase: sl(),
        deleteDayOffUseCase: sl(),
      ),
    );
  }
}
