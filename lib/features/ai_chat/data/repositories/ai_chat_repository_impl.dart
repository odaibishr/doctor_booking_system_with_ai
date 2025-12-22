import 'package:doctor_booking_system_with_ai/features/ai_chat/data/data_sources/ai_chat_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/domain/repositories/ai_chat_repository.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatRemoteDataSource remoteDataSource;

  AiChatRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<String> sendMessage(String message) {
    return remoteDataSource.sendMessage(message);
  }
}
