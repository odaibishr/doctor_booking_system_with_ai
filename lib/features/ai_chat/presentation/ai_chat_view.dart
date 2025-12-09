import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/ai_chat_body.dart';
import 'package:flutter/material.dart';

class AiChatView extends StatelessWidget {
  const AiChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: AiChatBody()));
  }
}
