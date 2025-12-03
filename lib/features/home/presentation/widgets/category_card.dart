// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });
  final bool color;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 85,
      decoration: BoxDecoration(
        boxShadow: [
          color
              ? BoxShadow(
                  color: const Color.fromARGB(69, 1, 1, 1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(3, 3),
                )
              : BoxShadow(),
        ],
        color: color ? AppColors.white : AppColors.gray200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.network(
            '${EndPoints.photoUrl}/$icon',
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: FontStyles.body2.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
