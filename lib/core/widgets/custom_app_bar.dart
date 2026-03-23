import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/manager/profile/profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:doctor_booking_system_with_ai/core/widgets/back_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show File;

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.isBackButtonVisible,
    required this.isUserImageVisible,
    this.isHeartIconVisible = false,
  });
  final String title;
  final bool isBackButtonVisible;
  final bool isUserImageVisible;
  final bool isHeartIconVisible;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isUserImageVisible && isHeartIconVisible == false
            ? Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    log('starting profile image');
                    if (state is ProfileFailure) {
                      log('failure profile image');
                      return const ClipOval(
                        child: Icon(Icons.person, color: Colors.white),
                      );
                    }
                    if (state is ProfileSuccess) {
                      log(
                        'success profile image ${state.profile.profileImage}',
                      );
                      final profileImage = state.profile.profileImage ?? '';
                      if (profileImage.trim().isEmpty ||
                          profileImage.trim().toLowerCase() == 'null') {
                        return const ClipOval(
                          child: Icon(Icons.person, color: Colors.white),
                        );
                      }
                      if (!kIsWeb &&
                          (profileImage.startsWith('/') ||
                              profileImage.startsWith('file://'))) {
                        final filePath = profileImage.startsWith('file://')
                            ? Uri.tryParse(profileImage)?.toFilePath()
                            : profileImage;
                        if (filePath != null && filePath.isNotEmpty) {
                          return ClipOval(
                            child: Image.file(
                              File(filePath),
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      }
                      return ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: profileImage.startsWith('http')
                              ? profileImage
                              : '${EndPoints.photoUrl}/$profileImage',
                          scale: 1,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person, color: Colors.white),
                        ),
                      );
                    }
                    return const ClipOval(
                      child: Icon(Icons.person, color: Colors.white),
                    );
                  },
                ),
              )
            : isHeartIconVisible && isUserImageVisible == false
            ? Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor),
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: primaryColor,
                  ),
                ),
              )
            : Opacity(
                opacity: 0,
                child: SizedBox.fromSize(size: const Size(38, 38)),
              ),

        Text(
          title,
          style: FontStyles.headLine4.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        isBackButtonVisible
            ? const BackButtons()
            : Opacity(
                opacity: 0,
                child: SizedBox.fromSize(size: const Size(38, 38)),
              ),
      ],
    );
  }
}
