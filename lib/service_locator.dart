// core/service_locator.dart
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/review_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/hospital_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/create_review_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/toggle_favorite_doctor_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/manager/hospital/hospital_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_service.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/manager/review/review_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/profile_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/profile_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/review_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/repos/logout_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/datasources/booking_history_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
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
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_specilaties_use_case.dart';
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
import 'package:doctor_booking_system_with_ai/features/search/presentation/manager/search_doctors_bloc/search_doctors_bloc.dart';
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
import 'package:hive_flutter/hive_flutter.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // Hive Initialization
  await HiveService.init();

  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());

  serviceLocator.registerLazySingleton<NotificationService>(
    () => NotificationService(AppRouter.navigatorKey),
  );

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
    () => ReviewRepoImpl(serviceLocator<ReviewRemoteDataSource>()),
  );

  serviceLocator.registerLazySingleton<AiChatRepository>(
    () => AiChatRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<LogoutRepo>(
    () => LogoutRepoImpl(
      serviceLocator<AuthRemoteDataSource>(),
      serviceLocator<AuthLocalDataSource>(),
      serviceLocator<ProfileLocalDataSource>(),
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

  serviceLocator.registerLazySingleton<GetSpecilatiesUseCase>(
    () => GetSpecilatiesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetDoctorDetailsUseCase>(
    () => GetDoctorDetailsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GetBookingHistoryUseCase>(
    () => GetBookingHistoryUseCase(serviceLocator()),
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

  serviceLocator.registerLazySingleton<GetHospitalsUseCase>(
    () => GetHospitalsUseCase(serviceLocator()),
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

  serviceLocator.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<CreateAppointmentUseCase>(
    () => CreateAppointmentUseCase(appoinmentRepo: serviceLocator()),
  );

  // Cubit
  serviceLocator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      signInUseCase: serviceLocator(),
      signUpUsecase: serviceLocator(),
      checkAuthSatusUsecase: serviceLocator(),
      logoutUseCase: serviceLocator(),
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

  serviceLocator.registerLazySingleton<HospitalCubit>(
    () => HospitalCubit(serviceLocator<GetHospitalsUseCase>()),
  );

  serviceLocator.registerFactory<HospitalDetailesCubit>(
    () => HospitalDetailesCubit(serviceLocator<GetHospitalDetailsUseCase>()),
  );

  serviceLocator.registerFactory<BookingHistoryCubit>(
    () => BookingHistoryCubit(serviceLocator()),
  );

  serviceLocator.registerFactory<ReviewCubit>(
    () => ReviewCubit(
      serviceLocator<CreateReviewUseCase>(),
      serviceLocator<GetDoctorReviewsUseCase>(),
    ),
  );

  serviceLocator.registerFactory<AiChatCubit>(
    () => AiChatCubit(aiChatRepository: serviceLocator()),
  );

  serviceLocator.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      paymentRepo: serviceLocator(),
      createAppointmentUseCase: serviceLocator(),
    ),
  );
}
