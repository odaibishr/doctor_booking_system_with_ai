// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/cached_network_svg.dart';
import 'package:flutter/material.dart';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:go_router/go_router.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    this.width = 85,
    this.height = 85,
  });
  final int id;
  final bool color;
  final String title;
  final String icon;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final trimmedIcon = icon.trim();
    return GestureDetector(
      onTap: () =>
          GoRouter.of(context).push("${AppRouter.searchViewRoute}?id=$id"),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            color
                ? BoxShadow(
                    color: AppColors.getShadow(context),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(3, 3),
                  )
                : BoxShadow(),
          ],
          color: context.gray200Color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (trimmedIcon.isEmpty)
              Icon(
                Icons.medical_services_outlined,
                color: context.primaryColor,
                size: 28,
              )
            else
              CachedNetworkSvg(
                url: '${EndPoints.photoUrl}/$trimmedIcon',
                fit: BoxFit.scaleDown,
                width: 28,
                height: 28,
                color: context.isDarkMode
                    ? context.whiteColor
                    : context.primaryColor,

                placeholderBuilder: (context) => const SizedBox(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              title,
              style: FontStyles.body2.copyWith(
                color: context.isDarkMode
                    ? context.whiteColor
                    : context.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
