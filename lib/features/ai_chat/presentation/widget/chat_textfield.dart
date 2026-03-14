import 'dart:io';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_state.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/chat_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        BlocBuilder<AiChatCubit, AiChatState>(
          builder: (context, state) {
            final isGenerating = (state is AiChatSuccess) && state.isGenerating;

            return IconButton(
              color: context.primaryColor,
              icon: isGenerating
                  ? Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.stop_rounded, color: Colors.red, size: 30),
                    )
                  : SvgPicture.asset('assets/icons/send_icon.svg', width: 58),
              onPressed: () {
                if (isGenerating) {
                  context.read<AiChatCubit>().stopGeneration();
                } else if (_controller.text.trim().isNotEmpty) {
                  widget.onSend(text: _controller.text.trim());
                  _controller.clear();
                  _scrollController.jumpTo(0);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
