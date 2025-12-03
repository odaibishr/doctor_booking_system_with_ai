import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class BottomSheetItems extends StatelessWidget {
  final VoidCallback ontap;
  final String icons;
  final String title;
  const BottomSheetItems({
    super.key,
    required this.icons,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 100,
        width: 110,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
          child: Column(
            children: [
              SvgPicture.asset(icons),
              SizedBox(height: 15),
              Text(
                title,
                style: FontStyles.subTitle3.copyWith(color: AppColors.gray100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
