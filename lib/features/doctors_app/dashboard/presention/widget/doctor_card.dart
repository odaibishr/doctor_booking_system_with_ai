import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final IconData cardIcon;
  final String cardTitle;
  final String cardContent;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final VoidCallback? onTap;

  const DoctorCard({
    super.key,
    required this.cardIcon,
    required this.cardTitle,
    required this.cardContent,
    this.iconColor,
    this.iconBackgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppColors.primary;
    final effectiveIconBg =
        iconBackgroundColor ?? AppColors.primary.withValues(alpha: 0.1);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: context.cardBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: effectiveIconBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(cardIcon, size: 22, color: effectiveIconColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    cardContent,
                    style: FontStyles.subTitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cardTitle,
                    style: FontStyles.body2.copyWith(color: AppColors.gray600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
