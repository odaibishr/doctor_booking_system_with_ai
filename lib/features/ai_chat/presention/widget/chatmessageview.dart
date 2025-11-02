import 'package:doctor_booking_system_with_ai/features/ai_chat/presention/widget/chat_bubble.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presention/widget/defualt_text.dart';
import 'package:flutter/material.dart';

class ChatMessageBuilder extends StatefulWidget {
  final List<Map<String, dynamic>> messages;
  const ChatMessageBuilder({super.key, required this.messages});

  @override
  State<ChatMessageBuilder> createState() => _ChatMessageBuilderState();
}

class _ChatMessageBuilderState extends State<ChatMessageBuilder> {
  @override
  Widget build(BuildContext context) {
    return (widget.messages.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                final msg = widget.messages[index];
                if (msg['type'] == 'text') {
                  final isUser = msg['isUser'] == true;
                  final content = msg['content']?.toString() ?? '';
                  return ChatBubble(isUser: isUser, content: content);
                }
                return const SizedBox.shrink();
              },
            ),
          )
        : DefualtText();
  }
}
