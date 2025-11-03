import 'dart:io';

import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presention/widget/chat_textfield.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presention/widget/chatmessageview.dart';

import 'package:flutter/material.dart';

class AiChatBody extends StatefulWidget {
  const AiChatBody({super.key});

  @override
  State<AiChatBody> createState() => _AiChatBodyState();
}

class _AiChatBodyState extends State<AiChatBody> {
  @override
  void dispose() {
    _messages.clear();
    super.dispose();
  }

  final List<Map<String, dynamic>> _messages = [];
  //add the message text or image to the list
  void _addtoMessageList({String? text, File? image}) {
    setState(() {
      if (text != null && text.isNotEmpty) {
        _messages.add({'type': 'text', 'isUser': true, 'content': text});
      } else if (image != null) {
        _messages.add({'type': 'image', 'isUser': true, 'content': image});
      }
    });

    // هنا سترسل إلى API الخاص بك مثلاً:
    // sendToApi(text: text, image: image);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          CustomAppBar(
            title: 'الطبيب الذكي',
            isBackButtonVisible: true,
            isUserImageVisible: false,
          ),
          Expanded(child: ChatMessageBuilder(messages: _messages)),
          Container(child: ChatTextField(onSend: _addtoMessageList)),
        ],
      ),
    );
  }
}
