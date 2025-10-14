import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 45,
    this.color = AppColors.primary,
    this.radius = 100,
  });
  final String text;
  final double height;
  final Function() onTap;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(
            text,
            style: FontStyles.subTitle2.copyWith(
              color: color == AppColors.primary
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
