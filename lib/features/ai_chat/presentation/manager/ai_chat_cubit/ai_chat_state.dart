import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

abstract class AiChatState {}

class AiChatInitial extends AiChatState {}

class AiChatLoading extends AiChatState {}

class AiChatSuccess extends AiChatState {
  final List<Map<String, dynamic>> messages;
  final Map<int, List<Doctor>> recommendedDoctors;
  final bool isGenerating;

  AiChatSuccess({
    required this.messages,
    this.recommendedDoctors = const {},
    this.isGenerating = false,
  });
}

class AiChatFailure extends AiChatState {
  final String errMessage;

  AiChatFailure({required this.errMessage});
}
