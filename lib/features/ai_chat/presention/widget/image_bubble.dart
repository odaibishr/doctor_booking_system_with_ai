import 'dart:io';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({
    super.key,
    required this.isUser,
    required this.imageFile,
  });

  final bool isUser;
  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return Align(
                 alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
                 child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                  color: isUser ? AppColors.gray400 : AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: Radius.circular(isUser ? 0 : 12),
                    bottomRight: Radius.circular(isUser ? 12 : 0),
                  ),
                  ),
                  child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.file(
                          imageFile,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
              );
  }
}