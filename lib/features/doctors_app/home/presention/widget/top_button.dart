import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  final VoidCallback onTap;
  final int selectedIndex;
  final int index;
  final String title;
  const TopButton({
    super.key, required this.onTap, required this.selectedIndex, required this.title, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 14, right: 14),
        decoration: BoxDecoration(
          color: (selectedIndex == index) ? AppColors.primaryColor : AppColors.gray400,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          title,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
