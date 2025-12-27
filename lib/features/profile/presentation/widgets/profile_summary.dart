import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({
    super.key,
    required this.name,
    required this.userImage,
    required this.phoneNumber,
  });
  final String name;
  final String userImage;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ImageProvider avatarProvider = _resolveImageProvider(userImage);

    return Column(
      children: [
        CircleAvatar(radius: 70, backgroundImage: avatarProvider),
        const SizedBox(height: 5),
        Text(
          name,
          style: FontStyles.headLine4.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          phoneNumber,
          style: FontStyles.subTitle2.copyWith(
            color: isDark ? AppColors.textSecondaryDark : AppColors.gray400,
          ),
        ),
      ],
    );
  }

  ImageProvider _resolveImageProvider(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.toLowerCase() == 'null') {
      return const AssetImage('assets/images/profile_image.png');
    }

    if (trimmed.startsWith('assets/')) {
      return AssetImage(trimmed);
    }

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return CachedNetworkImageProvider(trimmed);
    }

    if (!kIsWeb) {
      if (trimmed.startsWith('file://')) {
        final uri = Uri.tryParse(trimmed);
        final filePath = uri?.toFilePath();
        if (filePath != null && filePath.isNotEmpty) {
          return FileImage(File(filePath));
        }
      }

      if (trimmed.startsWith('/')) {
        return FileImage(File(trimmed));
      }
    }

    return CachedNetworkImageProvider('${EndPoints.photoUrl}/$trimmed');
  }
}
