abstract class AiChatState {}

class AiChatInitial extends AiChatState {}

class AiChatLoading extends AiChatState {}

class AiChatSuccess extends AiChatState {
  final List<Map<String, dynamic>>
  messages; // [{'role': 'user', 'text': '...'}, {'role': 'ai', 'text': '...'}]

  AiChatSuccess({required this.messages});
}

class AiChatFailure extends AiChatState {
  final String errMessage;

  AiChatFailure({required this.errMessage});
}
