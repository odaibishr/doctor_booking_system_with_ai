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
                ),
              );
            }
            if (state is ProfileSuccess) {
              return Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            '${EndPoints.photoUrl}/${state.profile.profileImage}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'مرحبا ${state.profile.user.name.split(' ')[0]}',
                    style: FontStyles.subTitle2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
