import 'dart:io';

import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_state.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/chat_textfield.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/chatmessageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart'; // Assuming toastification is used in project based on pubspec

class AiChatBody extends StatefulWidget {
  const AiChatBody({super.key});

  @override
  State<AiChatBody> createState() => _AiChatBodyState();
}

class _AiChatBodyState extends State<AiChatBody> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages =
      []; // Keep it to map state to UI format if needed, or use state directly

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

  void _sendMessage({String? text, File? image}) {
    if (text != null && text.isNotEmpty) {
      context.read<AiChatCubit>().sendMessage(text);
      // Wait for state update to scroll
    }
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
            child: BlocConsumer<AiChatCubit, AiChatState>(
              listener: (context, state) {
                if (state is AiChatSuccess) {
                  _messages = state.messages.map((m) {
                    return {
                      'type': 'text',
                      'isUser': m['role'] == 'user',
                      'content': m['text'],
                    };
                  }).toList();
                  _scrollToBottom();
                } else if (state is AiChatFailure) {
                  toastification.show(
                    context: context,
                    title: Text("حدث خطأ"),
                    description: Text(state.errMessage),
                    autoCloseDuration: const Duration(seconds: 3),
                    type: ToastificationType.error,
                    style: ToastificationStyle.flat,
                  );
                }
              },
              builder: (context, state) {
                // Initial message if empty
                if (_messages.isEmpty && state is AiChatInitial) {
                  return Center(child: Text("ابدأ المحادثة مع مساعدك الطبي"));
                }

                return ChatMessageBuilder(
                  messages: _messages,
                  controller: _scrollController,
                );
              },
            ),
          ),
          ChatTextField(onSend: _sendMessage),
        ],
      ),
    );
  }
}
