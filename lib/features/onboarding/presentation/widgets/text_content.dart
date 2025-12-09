import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class TextContent extends StatelessWidget {
  final String title;
  final String description;

  final bool isActive;

  const TextContent({
    super.key,
    required this.title,
    required this.description,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          width: double.infinity,
          child: Center(
            child: AnimatedScale(
              scale: isActive ? 1.0 : 0.88,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
              child: Container(
                height: isActive ? 90 : 65,
                width: isActive ? double.infinity : 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: FontStyles.headLine4.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.black : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: FontStyles.subTitle3.copyWith(
                          color: isActive ? AppColors.black : AppColors.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
