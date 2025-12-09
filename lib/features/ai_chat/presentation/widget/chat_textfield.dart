import 'dart:io';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/chat_input_field.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ChatTextField extends StatefulWidget {
  final Function({String? text, File? image}) onSend;

  const ChatTextField({super.key, required this.onSend});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChatInputField(
            controller: _controller,
            scrollController: _scrollController,
            onSend: widget.onSend,
          ),
        ),
        IconButton(
          icon: SvgPicture.asset('assets/icons/send_icon.svg', width: 58),
          onPressed: () {
            if (_controller.text.trim().isNotEmpty) {
              widget.onSend(text: _controller.text.trim());
              _controller.clear();
              _scrollController.jumpTo(0);
            }
          },
        ),
      ],
    );
  }
}
