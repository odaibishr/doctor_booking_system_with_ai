import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
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
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(userImage, scale: 1, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              name,
              style: FontStyles.subTitle2.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),

        Container(
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
      ],
    );
  }
}
