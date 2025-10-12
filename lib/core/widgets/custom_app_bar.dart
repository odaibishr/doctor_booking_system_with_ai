import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:doctor_booking_system_with_ai/core/widgets/back_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.userImage,
    required this.title,
    required this.isBackButtonVisible,
    required this.isUserImageVisible,
  });
  final String userImage;
  final String title;
  final bool isBackButtonVisible;
  final bool isUserImageVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isUserImageVisible
            ? Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(userImage, scale: 1, fit: BoxFit.cover),
                ),
              )
            : const SizedBox.shrink(),

        Text(
          title,
          style: FontStyles.headLine4.copyWith(fontWeight: FontWeight.bold),
        ),
        isBackButtonVisible ? const BackButton() : const SizedBox.shrink(),
      ],
    );
  }
}
