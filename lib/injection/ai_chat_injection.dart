import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/data/data_sources/ai_chat_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/data/repositories/ai_chat_repository_impl.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_cubit.dart';

class AiChatInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<AiChatRemoteDataSource>(
      () => AiChatRemoteDataSourceImpl(dio: Dio()),
    );

    sl.registerLazySingleton<AiChatRepository>(
      () => AiChatRepositoryImpl(remoteDataSource: sl()),
    );

    sl.registerFactory<AiChatCubit>(
      () => AiChatCubit(
        aiChatRepository: sl(),
        getDoctorsUseCase: sl<GetDoctorsUseCase>(),
        getSpecialtiesUseCase: sl<GetSpecialtiesUseCase>(),
      ),
    );
  }
}
