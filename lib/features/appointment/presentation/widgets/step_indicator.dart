import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    const steps = ['اليوم', 'الوقت', 'تأكيد الحجز'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (index) {
        final label = steps[index];
        final isActive = currentStep >= index;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? AppColors.getPrimary(context)
                      : AppColors.getGray400(context),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: FontStyles.body1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: FontStyles.subTitle3.copyWith(
                  color: isActive
                      ? AppColors.getPrimary(context)
                      : AppColors.getGray400(context),
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
