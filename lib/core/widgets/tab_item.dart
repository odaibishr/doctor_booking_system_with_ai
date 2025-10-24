import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: 1.0,
          child: Text(
            text,
            style: FontStyles.subTitle3.copyWith(
              color: isSelected ? AppColors.primary : AppColors.gray500,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
