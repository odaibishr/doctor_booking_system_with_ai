import 'dart:io';

import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_state.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/chat_textfield.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/chatmessageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiChatBody extends StatefulWidget {
  const AiChatBody({super.key});

  @override
  State<AiChatBody> createState() => _AiChatBodyState();
}

class _AiChatBodyState extends State<AiChatBody> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [];
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
            child: BlocBuilder<AiChatCubit, AiChatState>(
              builder: (context, state) {
                if (_messages.isEmpty && state is AiChatInitial) {
                  return Center(child: Text("ابدأ المحادثة مع مساعدك الطبي"));
                }

                if (state is AiChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is AiChatSuccess) {
                  _scrollToBottom();
                  return ChatMessageBuilder(
                    messages: state.messages.map((m) {
                      String content = m['text'] ?? '';
                      content = content
                          .replaceAll(
                            RegExp(
                              r'###SPECIALTY:\s*[^\n]+\n?',
                              caseSensitive: false,
                            ),
                            '',
                          )
                          .trim();
                      return {
                        'type': 'text',
                        'isUser': m['role'] == 'user',
                        'content': content,
                        'isDone': m['isDone'] ?? true,
                      };
                    }).toList(),
                    controller: _scrollController,
                    recommendedDoctors: state.recommendedDoctors,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          ChatTextField(onSend: _sendMessage),
        ],
      ),
    );
  }
}
