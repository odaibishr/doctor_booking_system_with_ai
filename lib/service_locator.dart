// core/service_locator.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/reivew_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/review_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/hospital_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/create_review_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/watch_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/refresh_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/watch_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/refresh_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_all_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_all_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/toggle_favorite_doctor_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/manager/hospital/hospital_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_service.dart';
import 'package:doctor_booking_system_with_ai/core/manager/network/network_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/manager/review/review_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/services/google_sign_in_service.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/profile_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/profile_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/review_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/repos/logout_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/google_sign_in_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/datasources/booking_history_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/cancel_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/reschedule_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/usecases/create_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/manager/profile/profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/datasources/booking_history_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/repos/booking_history_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/get_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/manager/booking_history_cubit/booking_history_cubit.dart';
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
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_specilaties_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_appointment_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_dashboard_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/get_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/presentation/manager/favorite_doctor_cubit/favorite_doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor_details/doctor_details_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/toggle_favorite/toggle_favorite_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/domain/use_cases/get_hostpital_details_use_cae.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/manager/hospital_detailes/hospital_detailes_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/repos/logout_repo.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/use_cases/logout_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/search/domain/usecases/search_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/map/presentation/manager/map_bloc.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/manager/search_doctors_cubit/search_doctors_cubit.dart';

import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/data/data_sources/ai_chat_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/data/repositories/ai_chat_repository_impl.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/repos/auth_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/check_auth_satus_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/data/data_sources/appointment_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/data/repos/appointment_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/repos/appoinment_repo.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/use_cases/create_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/payment/data/repos/payment_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/payment/domain/repos/payment_repo.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/manager/payment_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/manager/theme/theme_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_dashboard_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_appointment_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/repos/doctor_dashboard_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/repos/doctor_appointment_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_dashboard_repo.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_dashboard_stats_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_appointment_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_appointment_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_appointments_by_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_appointments_by_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_dashboard_stats_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_dashboard_stats_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_my_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_profile_image_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_schedules_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_schedule_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_days_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/create_day_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/delete_day_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/dashboard/doctor_dashboard_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/appointments/doctor_appointments_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/reviews/doctor_reviews_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_my_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/repos/doctor_profile_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_schedule_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/core/services/fcm_service.dart';
import 'package:doctor_booking_system_with_ai/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/notification/data/repos/notification_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/notification/domain/repos/notification_repo.dart';
import 'package:doctor_booking_system_with_ai/features/notification/presentation/manager/notification_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/appointment_refresh_service.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // Hive Initialization
  await HiveService.init();

  serviceLocator.registerLazySingleton(() => GoogleSignInService());

  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());

  serviceLocator.registerLazySingleton<NotificationService>(
    () => NotificationService(AppRouter.navigatorKey),
  );

  serviceLocator.registerLazySingleton<PusherService>(
    () => PusherService(),
  );

  serviceLocator.registerLazySingleton<AppointmentRefreshService>(
    () => AppointmentRefreshService(
      serviceLocator<PusherService>(),
      serviceLocator<FcmService>(),
    ),
  );

  // Network
  serviceLocator.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator<Connectivity>()),
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

  serviceLocator.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<BookingHistoryRemoteDataSource>(
    () => BookingHistoryRemoteDataSourceImpl(serviceLocator()),
  );

  final bookingHistoryBox = Hive.box<Booking>(kBookingHistoryBox);
  serviceLocator.registerLazySingleton<BookingHistoryLocalDataSource>(
    () => BookingHistoryLocalDataSourceImpl(bookingHistoryBox),
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

  serviceLocator.registerLazySingleton<HospitalRemoteDataSource>(
    () => HospitalRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(serviceLocator()),
  );

  final reviewBox = Hive.box<Review>(kReviewBox);
  serviceLocator.registerLazySingleton<ReviewLocalDataSource>(
    () => ReviewLocalDataSourceImpl(reviewBox),
  );

  final hospitalsBox = Hive.box<Hospital>(kHospitalBox);
  serviceLocator.registerLazySingleton<HospitalLocalDataSource>(
    () => HospitalLocalDataSourceImpl(hospitalsBox),
  );

  serviceLocator.registerLazySingleton<AiChatRemoteDataSource>(
    () => AiChatRemoteDataSourceImpl(dio: Dio()),
  );

  serviceLocator.registerLazySingleton<AppointmentRemoteDataSource>(
    () => AppointmentRemoteDataSourceImpl(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      authRemoteDataSource: serviceLocator(),
      authLocalDataSource: serviceLocator(),
      googleSignInService: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(
      serviceLocator<ProfileRemoteDataSource>(),
      serviceLocator<ProfileLocalDataSource>(),
      serviceLocator<NetworkInfo>(),
    ),
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

  serviceLocator.registerLazySingleton<BookingHistoryRepo>(
    () => BookingHistoryRepoImpl(
      localDataSource: serviceLocator(),
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<HospitalRepo>(
    () => HospitalRepoImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<ReviewRepo>(
    () => ReviewRepoImpl(
      serviceLocator<ReviewRemoteDataSource>(),
      serviceLocator<ReviewLocalDataSource>(),
      serviceLocator<NetworkInfo>(),
    ),
  );

  serviceLocator.registerLazySingleton<AiChatRepository>(
    () => AiChatRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<LogoutRepo>(
    () => LogoutRepoImpl(
      serviceLocator<AuthRemoteDataSource>(),
      serviceLocator<AuthLocalDataSource>(),
      serviceLocator<ProfileLocalDataSource>(),
      serviceLocator<GoogleSignInService>(),
    ),
  );

  serviceLocator.registerLazySingleton<AppoinmentRepo>(
    () => AppointmentRepoImpl(remoteDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<PaymentRepo>(() => PaymentRepoImpl());

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

  serviceLocator.registerLazySingleton<WatchDoctorsUseCase>(
    () => WatchDoctorsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RefreshDoctorsUseCase>(
    () => RefreshDoctorsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetSpecilatiesUseCase>(
    () => GetSpecilatiesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetDoctorDetailsUseCase>(
    () => GetDoctorDetailsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetBookingHistoryUseCase>(
    () => GetBookingHistoryUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<WatchBookingHistoryUseCase>(
    () => WatchBookingHistoryUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RefreshBookingHistoryUseCase>(
    () => RefreshBookingHistoryUseCase(serviceLocator()),
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

  serviceLocator.registerLazySingleton<WatchDoctorDetailsUseCase>(
    () => WatchDoctorDetailsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RefreshDoctorDetailsUseCase>(
    () => RefreshDoctorDetailsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<WatchFavoriteDoctorsUseCase>(
    () => WatchFavoriteDoctorsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RefreshFavoriteDoctorsUseCase>(
    () => RefreshFavoriteDoctorsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetHospitalsUseCase>(
    () => GetHospitalsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<WatchHospitalsUseCase>(
    () => WatchHospitalsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RefreshHospitalsUseCase>(
    () => RefreshHospitalsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<WatchSpecialtiesUseCase>(
    () => WatchSpecialtiesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RefreshSpecialtiesUseCase>(
    () => RefreshSpecialtiesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<WatchAllSpecialtiesUseCase>(
    () => WatchAllSpecialtiesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RefreshAllSpecialtiesUseCase>(
    () => RefreshAllSpecialtiesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetHospitalDetailsUseCase>(
    () => GetHospitalDetailsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<CreateReviewUseCase>(
    () => CreateReviewUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetDoctorReviewsUseCase>(
    () => GetDoctorReviewsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<WatchDoctorReviewsUseCase>(
    () => WatchDoctorReviewsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RefreshDoctorReviewsUseCase>(
    () => RefreshDoctorReviewsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<CreateAppointmentUseCase>(
    () => CreateAppointmentUseCase(appoinmentRepo: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<CancelAppointmentUseCase>(
    () => CancelAppointmentUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RescheduleAppointmentUseCase>(
    () => RescheduleAppointmentUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GoogleSignInUseCase>(
    () => GoogleSignInUseCase(serviceLocator()),
  );

  // Cubit
  serviceLocator.registerLazySingleton<NetworkCubit>(
    () => NetworkCubit(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      signInUseCase: serviceLocator(),
      signUpUsecase: serviceLocator(),
      checkAuthSatusUsecase: serviceLocator(),
      logoutUseCase: serviceLocator(),
      googleSignInUseCase: serviceLocator(),
      pusherService: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(
      serviceLocator<CreateProfileUseCase>(),
      serviceLocator<GetProfileUseCase>(),
      serviceLocator<LogoutUseCase>(),
    ),
  );

  serviceLocator.registerLazySingleton<DoctorCubit>(
    () => DoctorCubit(
      watchDoctorsUseCase: serviceLocator(),
      refreshDoctorsUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<DoctorDetailsCubit>(
    () => DoctorDetailsCubit(
      watchDoctorDetailsUseCase: serviceLocator(),
      refreshDoctorDetailsUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<SpecialtyCubit>(
    () => SpecialtyCubit(
      watchSpecialtiesUseCase: serviceLocator(),
      refreshSpecialtiesUseCase: serviceLocator(),
      watchAllSpecialtiesUseCase: serviceLocator(),
      refreshAllSpecialtiesUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<SearchDoctorsCubit>(
    () => SearchDoctorsCubit(
      serviceLocator<SearchDoctorsUseCase>(),
      serviceLocator<GetDoctorsUseCase>(),
    ),
  );

  serviceLocator.registerFactory<MapBloc>(
    () => MapBloc(getDoctorsUseCase: serviceLocator<GetDoctorsUseCase>()),
  );

  serviceLocator.registerLazySingleton<FavoriteDoctorCubit>(
    () => FavoriteDoctorCubit(
      watchFavoriteDoctorsUseCase: serviceLocator(),
      refreshFavoriteDoctorsUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<ToggleFavoriteCubit>(
    () => ToggleFavoriteCubit(
      serviceLocator(),
      serviceLocator<DoctorCubit>(),
      serviceLocator<FavoriteDoctorCubit>(),
      serviceLocator<DoctorDetailsCubit>(),
    ),
  );

  serviceLocator.registerLazySingleton<HospitalCubit>(
    () => HospitalCubit(
      watchHospitalsUseCase: serviceLocator(),
      refreshHospitalsUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<HospitalDetailesCubit>(
    () => HospitalDetailesCubit(serviceLocator<GetHospitalDetailsUseCase>()),
  );

  serviceLocator.registerFactory<BookingHistoryCubit>(
    () => BookingHistoryCubit(
      cancelAppointmentUseCase: serviceLocator(),
      rescheduleAppointmentUseCase: serviceLocator(),
      watchBookingHistoryUseCase: serviceLocator(),
      refreshBookingHistoryUseCase: serviceLocator(),
      pusherService: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<ReviewCubit>(
    () => ReviewCubit(
      createReviewUseCase: serviceLocator(),
      watchDoctorReviewsUseCase: serviceLocator(),
      refreshDoctorReviewsUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AiChatCubit>(
    () => AiChatCubit(
      aiChatRepository: serviceLocator(),
      doctorRepo: serviceLocator(),
      specialtyRepo: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      paymentRepo: serviceLocator(),
      createAppointmentUseCase: serviceLocator(),
    ),
  );

  // Theme Cubit - manages app theme (light/dark/system)
  serviceLocator.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // FCM & Notification Feature
  serviceLocator.registerLazySingleton<FcmService>(
    () => FcmService(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<NotificationRepo>(
    () => NotificationRepoImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<NotificationCubit>(
    () => NotificationCubit(serviceLocator()),
  );



  // Doctor App Feature - Data Sources
  serviceLocator.registerLazySingleton<DoctorDashboardRemoteDataSource>(
    () => DoctorDashboardRemoteDataSourceImpl(serviceLocator()),
  );

  final dashboardBox = Hive.box<DashboardStats>(kDashboardBox);
  serviceLocator.registerLazySingleton<DoctorDashboardLocalDataSource>(
    () => DoctorDashboardLocalDataSourceImpl(box: dashboardBox),
  );

  serviceLocator.registerLazySingleton<DoctorAppointmentRemoteDataSource>(
    () => DoctorAppointmentRemoteDataSourceImpl(serviceLocator()),
  );

  final appointmentBox = Hive.box<List<DoctorAppointment>>(kDoctorAppointmentBox);
  serviceLocator.registerLazySingleton<DoctorAppointmentLocalDataSource>(
    () => DoctorAppointmentLocalDataSourceImpl(appointmentBox),
  );

  // Doctor App Feature - Repos

  serviceLocator.registerLazySingleton<DoctorDashboardRepo>(
    () => DoctorDashboardRepoImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<DoctorAppointmentRepo>(
    () => DoctorAppointmentRepoImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );

  // Doctor App Feature - UseCases
  serviceLocator.registerLazySingleton<GetDashboardStatsUseCase>(
    () => GetDashboardStatsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetTodayAppointmentsUseCase>(
    () => GetTodayAppointmentsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetUpcomingAppointmentsUseCase>(
    () => GetUpcomingAppointmentsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetHistoryAppointmentsUseCase>(
    () => GetHistoryAppointmentsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UpdateAppointmentStatusUseCase>(
    () => UpdateAppointmentStatusUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetAppointmentDetailsUseCase>(
    () => GetAppointmentDetailsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetAppointmentsUseCase>(
    () => GetAppointmentsUseCase(serviceLocator()),
  );

  // Doctor App Feature - Watch and Refresh UseCases
  serviceLocator.registerLazySingleton<WatchTodayAppointmentsUseCase>(
    () => WatchTodayAppointmentsUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<RefreshTodayAppointmentsUseCase>(
    () => RefreshTodayAppointmentsUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<WatchUpcomingAppointmentsUseCase>(
    () => WatchUpcomingAppointmentsUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<RefreshUpcomingAppointmentsUseCase>(
    () => RefreshUpcomingAppointmentsUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<WatchHistoryAppointmentsUseCase>(
    () => WatchHistoryAppointmentsUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<RefreshHistoryAppointmentsUseCase>(
    () => RefreshHistoryAppointmentsUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<WatchAppointmentsByStatusUseCase>(
    () => WatchAppointmentsByStatusUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<RefreshAppointmentsByStatusUseCase>(
    () => RefreshAppointmentsByStatusUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<WatchDashboardStatsUseCase>(
    () => WatchDashboardStatsUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<RefreshDashboardStatsUseCase>(
    () => RefreshDashboardStatsUseCase(serviceLocator()),
  );

  // Doctor App Feature - Cubits
  serviceLocator.registerFactory<DoctorDashboardCubit>(
    () => DoctorDashboardCubit(
      watchDashboardStatsUseCase: serviceLocator(),
      refreshDashboardStatsUseCase: serviceLocator(),
      pusherService: serviceLocator(),
      fcmService: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<DoctorAppointmentsCubit>(
    () => DoctorAppointmentsCubit(
      updateAppointmentStatusUseCase: serviceLocator(),
      watchTodayAppointmentsUseCase: serviceLocator(),
      refreshTodayAppointmentsUseCase: serviceLocator(),
      watchUpcomingAppointmentsUseCase: serviceLocator(),
      refreshUpcomingAppointmentsUseCase: serviceLocator(),
      watchHistoryAppointmentsUseCase: serviceLocator(),
      refreshHistoryAppointmentsUseCase: serviceLocator(),
      watchAppointmentsByStatusUseCase: serviceLocator(),
      refreshAppointmentsByStatusUseCase: serviceLocator(),
      pusherService: serviceLocator(),
      fcmService: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<GetMyReviewsUseCase>(
    () => GetMyReviewsUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory<DoctorReviewsCubit>(
    () => DoctorReviewsCubit(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerLazySingleton<DoctorProfileRemoteDataSource>(
    () => DoctorProfileRemoteDataSourceImpl(serviceLocator()),
  );

  final doctorProfileBox = Hive.box<Doctor>(kProfileBox);
  final doctorSchedulesBox = Hive.box<List<DoctorSchedule>>(kDoctorMySchedulesBox);
  final doctorDaysOffBox = Hive.box<List<DoctorDayOff>>(kDoctorDaysOffBox);

  serviceLocator.registerLazySingleton<DoctorProfileLocalDataSource>(
    () => DoctorProfileLocalDataSourceImpl(
      profileBox: doctorProfileBox,
      schedulesBox: doctorSchedulesBox,
      daysOffBox: doctorDaysOffBox,
    ),
  );

  serviceLocator.registerLazySingleton<DoctorProfileRepo>(
    () => DoctorProfileRepoImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );

  // Doctor App Feature - Profile & Schedule UseCases
  serviceLocator.registerLazySingleton<GetMyProfileUseCase>(
    () => GetMyProfileUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UpdateProfileImageUseCase>(
    () => UpdateProfileImageUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetSchedulesUseCase>(
    () => GetSchedulesUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UpdateScheduleUseCase>(
    () => UpdateScheduleUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetDaysOffUseCase>(
    () => GetDaysOffUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CreateDayOffUseCase>(
    () => CreateDayOffUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<DeleteDayOffUseCase>(
    () => DeleteDayOffUseCase(serviceLocator()),
  );

  // Doctor App Feature - Profile & Schedule Cubits
  serviceLocator.registerFactory<DoctorProfileCubit>(
    () => DoctorProfileCubit(
      getMyProfileUseCase: serviceLocator(),
      updateProfileUseCase: serviceLocator(),
      updateProfileImageUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<DoctorScheduleCubit>(
    () => DoctorScheduleCubit(
      getSchedulesUseCase: serviceLocator(),
      updateScheduleUseCase: serviceLocator(),
      getDaysOffUseCase: serviceLocator(),
      createDayOffUseCase: serviceLocator(),
      deleteDayOffUseCase: serviceLocator(),
    ),
  );
}
