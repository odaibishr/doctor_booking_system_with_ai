import 'dart:io';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presention/widget/upload_button.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final ScrollController scrollController;
  final Function({String? text, File? image}) onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.onSend,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,

      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF364989),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 0,
            bottom: 0,
            child: UploadButton(onSend: widget.onSend),
          ),
          Positioned(
            left: 60,
            right: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: Scrollbar(
                controller: widget.scrollController,
                radius: const Radius.circular(10),
                thickness: 2,
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  scrollDirection: Axis.vertical,
                  child: TextField(
                    controller: widget.controller,
                    style: FontStyles.body1.copyWith(color: AppColors.white),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'اوصف حالتك ...',
                      hintStyle: FontStyles.body1.copyWith(
                        color: AppColors.gray100,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                    onChanged: (_) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        widget.scrollController.animateTo(
                          widget.scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
