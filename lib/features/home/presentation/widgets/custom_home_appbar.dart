import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/manager/profile/profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show File;

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
    required this.name,
    required this.userImage,
  });
  final String name;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileFailure) {
              return Text(
                state.errorMessage,
                style: FontStyles.subTitle2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextPrimary(context),
                ),
              );
            }
            if (state is ProfileSuccess) {
              final profileImage = (state.profile.profileImage ?? '').trim();
              final hasValidImage =
                  profileImage.isNotEmpty &&
                  profileImage.toLowerCase() != 'null';
              final isLocalFile =
                  !kIsWeb &&
                  (profileImage.startsWith('/') ||
                      profileImage.startsWith('file://'));
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.getPrimary(context),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: (!hasValidImage)
                            ? Image.asset(userImage, fit: BoxFit.cover)
                            : isLocalFile
                            ? Image.file(
                                File(
                                  profileImage.startsWith('file://')
                                      ? (Uri.tryParse(
                                              profileImage,
                                            )?.toFilePath() ??
                                            profileImage)
                                      : profileImage,
                                ),
                                fit: BoxFit.cover,
                              )
                            : hasValidImage
                            ? CachedNetworkImage(
                                imageUrl: '${EndPoints.photoUrl}/$profileImage',
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Image.asset(userImage, fit: BoxFit.cover),
                              )
                            : Image.asset(userImage, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        'مرحبا ${state.profile.user.name.split(' ')[0]}',
                        style: FontStyles.subTitle2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.getTextPrimary(context),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),

        GestureDetector(
          onTap: () =>
              GoRouter.of(context).push(AppRouter.notificationViewRoute),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              width: 20,
              height: 20,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ],
    );
  }
}
