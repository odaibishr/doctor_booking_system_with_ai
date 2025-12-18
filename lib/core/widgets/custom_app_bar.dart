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
    this.userImage,
    required this.title,
    required this.isBackButtonVisible,
    required this.isUserImageVisible,
    this.isHeartIconVisible = false,
  });
  final String? userImage;
  final String title;
  final bool isBackButtonVisible;
  final bool isUserImageVisible;
  final bool isHeartIconVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isUserImageVisible && isHeartIconVisible == false
            ? Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    log('starting profile image');
                    if (state is ProfileFailure) {
                      log('failure profile image');
                      return ClipOval(
                        child: Image.asset(
                          userImage!,
                          scale: 1,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    if (state is ProfileSuccess) {
                      log(
                        'success profile image ${state.profile.profileImage}',
                      );
                      final profileImage = state.profile.profileImage ?? '';
                      if (profileImage.trim().isEmpty ||
                          profileImage.trim().toLowerCase() == 'null') {
                        return ClipOval(
                          child: Image.asset(
                            userImage!,
                            scale: 1,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      if (!kIsWeb &&
                          (profileImage.startsWith('/') ||
                              profileImage.startsWith('file://'))) {
                        final filePath =
                            profileImage.startsWith('file://')
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
                          imageUrl:
                              '${EndPoints.photoUrl}/$profileImage',
                          scale: 1,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return ClipOval(
                      child: Image.asset(
                        userImage!,
                        scale: 1,
                        fit: BoxFit.cover,
                      ),
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
                  border: Border.all(color: AppColors.primary),
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.primary,
                  ),
                ),
              )
            : Opacity(
                opacity: 0,
                child: SizedBox.fromSize(size: const Size(38, 38)),
              ),

        Text(
          title,
          style: FontStyles.headLine4.copyWith(fontWeight: FontWeight.bold),
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
