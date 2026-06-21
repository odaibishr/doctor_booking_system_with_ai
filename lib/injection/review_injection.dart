import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/review_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/review_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/repos/review_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/create_review_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctor_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_my_reviews_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/manager/review/review_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';

class ReviewInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<ReviewRemoteDataSource>(
      () => ReviewRemoteDataSourceImpl(sl()),
    );

    final reviewBox = Hive.box<Review>(kReviewBox);
    sl.registerLazySingleton<ReviewLocalDataSource>(
      () => ReviewLocalDataSourceImpl(reviewBox),
    );

    sl.registerLazySingleton<ReviewRepo>(
      () => ReviewRepoImpl(
        sl<ReviewRemoteDataSource>(),
        sl<ReviewLocalDataSource>(),
        sl<NetworkInfo>(),
      ),
    );

    // Use Cases
    sl.registerLazySingleton<CreateReviewUseCase>(
      () => CreateReviewUseCase(sl()),
    );
    sl.registerLazySingleton<GetDoctorReviewsUseCase>(
      () => GetDoctorReviewsUseCase(sl()),
    );
    sl.registerLazySingleton<WatchDoctorReviewsUseCase>(
      () => WatchDoctorReviewsUseCase(sl()),
    );
    sl.registerLazySingleton<RefreshDoctorReviewsUseCase>(
      () => RefreshDoctorReviewsUseCase(sl()),
    );
    sl.registerLazySingleton<GetMyReviewsUseCase>(
      () => GetMyReviewsUseCase(sl()),
    );

    // Cubit
    sl.registerFactory<ReviewCubit>(
      () => ReviewCubit(
        createReviewUseCase: sl(),
        watchDoctorReviewsUseCase: sl(),
        refreshDoctorReviewsUseCase: sl(),
      ),
    );
  }
}
