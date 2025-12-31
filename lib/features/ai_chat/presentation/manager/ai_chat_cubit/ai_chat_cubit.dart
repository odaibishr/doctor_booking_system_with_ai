import 'dart:developer';
import 'package:doctor_booking_system_with_ai/core/errors/exceptions.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final AiChatRepository aiChatRepository;
  final List<Map<String, dynamic>> _messages = [];

  AiChatCubit({required this.aiChatRepository}) : super(AiChatInitial());

  Future<void> sendMessage(String message) async {
    // Add user message immediately
    _messages.add({'role': 'user', 'text': message, 'isDone': false});
    emit(
      AiChatSuccess(messages: List.from(_messages)),
    ); // Emit to show user message

    // Show loading indicator implicitly by keeping the list but maybe handle loading separately in UI if needed
    // or emit a loading state ONLY if we want to block interaction, but for chat we usually just show "typing..."
    // For simplicity, let's keep it Success but update the list.
    // However, to show a loader, we might need a specific handling.
    // Let's create a temporary loading message or handle it in UI.

    // Let's emit Loading if it's the first message, or just keep Success.
    // To conform to standard patterns, let's try to just await the response.

    // Initialize AI message placeholder
    _messages.add({'role': 'ai', 'text': ''});
    int aiIndex = _messages.length - 1;

    // We emit success immediately so the UI shows the empty/typing bubble
    emit(AiChatSuccess(messages: List.from(_messages)));

    try {
      final stream = aiChatRepository.sendMessage(message);

      stream.listen(
        (chunk) {
          final currentText = _messages[aiIndex]['text'] ?? '';
          _messages[aiIndex]['text'] = currentText + chunk;
          emit(AiChatSuccess(messages: List.from(_messages)));
        },
        onError: (error) {
          String errorMessage = error.toString();
          if (error is ServerException) {
            errorMessage = error.errorModel.errorMessage;
          }
          log('Error in stream: $errorMessage');
          // Remove the partial message or show error indicator?
          // Let's Keep partial message and show toast error
          emit(AiChatFailure(errMessage: errorMessage));
        },
        onDone: () {
          // Stream finished
          log('Stream done');
          _messages[aiIndex]['isDone'] = true ;
          emit(AiChatSuccess(messages: List.from(_messages)));
        },
      );
    } catch (e) {
      log('Error initiating stream: $e');
      emit(AiChatFailure(errMessage: e.toString()));
    }
  }
}
