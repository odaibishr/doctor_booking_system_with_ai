import 'dart:io';

import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/chat_textfield.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/chatmessageview.dart';
import 'package:flutter/material.dart';

class AiChatBody extends StatefulWidget {
  const AiChatBody({super.key});

  @override
  State<AiChatBody> createState() => _AiChatBodyState();
}

class _AiChatBodyState extends State<AiChatBody> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _addtoMessageList({String? text, File? image}) {
    setState(() {
      if (text != null && text.isNotEmpty) {
        _messages.add({'type': 'text', 'isUser': true, 'content': text});
        _scrollToBottom();
      } else if (image != null) {
        _messages.add({'type': 'image', 'isUser': true, 'content': image});
        _scrollToBottom();
      }

      _messages.add({
        'type': 'text',
        'isUser': false,
        'content': 'مرحباً بك، كيف يمكنني مساعدتك؟',
      });

      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messages.clear();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      child: Column(
        children: [
          CustomAppBar(
            title: 'الدردشة الذكية',
            isBackButtonVisible: true,
            isUserImageVisible: false,
          ),
          Expanded(
            child: ChatMessageBuilder(
              messages: _messages,
              controller: _scrollController,
            ),
          ),
          ChatTextField(onSend: _addtoMessageList),
        ],
      ),
    );
  }
}

