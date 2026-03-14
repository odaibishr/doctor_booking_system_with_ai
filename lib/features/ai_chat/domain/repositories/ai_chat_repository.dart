abstract class AiChatRepository {
  Stream<String> sendMessage(List<Map<String, dynamic>> history);
}
