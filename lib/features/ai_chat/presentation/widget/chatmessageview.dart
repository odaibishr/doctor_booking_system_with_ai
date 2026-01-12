import 'dart:io';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/chat_bubble.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/defualt_text.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/image_bubble.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/recommended_doctors_widget.dart';
import 'package:flutter/material.dart';

class ChatMessageBuilder extends StatefulWidget {
  final ScrollController controller;
  final List<Map<String, dynamic>> messages;
  final Map<int, List<Doctor>> recommendedDoctors;

  const ChatMessageBuilder({
    super.key,
    required this.messages,
    required this.controller,
    this.recommendedDoctors = const {},
  });

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
              controller: widget.controller,
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                final msg = widget.messages[index];
                if (msg['type'] == 'text') {
                  final isUser = msg['isUser'] == true;
                  final content = msg['content']?.toString() ?? '';
                  final isDone = msg['isDone'] == true;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ChatBubble(
                        isUser: isUser,
                        content: content,
                        key: ValueKey(msg['content']),
                        isDone: isDone,
                      ),
                      if (!isUser &&
                          widget.recommendedDoctors.containsKey(index))
                        RecommendedDoctorsWidget(
                          doctors: widget.recommendedDoctors[index]!,
                        ),
                    ],
                  );
                } else {
                  final isUser = msg['isUser'] == true;
                  if (msg['type'] == 'image' && msg['content'] is File) {
                    final File imageFile = msg['content'];
                    return ImageBubble(isUser: isUser, imageFile: imageFile);
                  }
                }

                return const SizedBox.shrink();
              },
            ),
          )
        : DefualtText();
  }
}
