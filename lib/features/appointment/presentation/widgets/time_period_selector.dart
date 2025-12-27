import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class TimePeriodSelector extends StatelessWidget {
  const TimePeriodSelector({
    super.key,
    required this.selectedPeriodKey,
    required this.onPeriodSelected,
  });

  final String? selectedPeriodKey;
  final ValueChanged<String> onPeriodSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.gray100Color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.gray300Color.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'اختر الفترة',
            style: FontStyles.headLine4.copyWith(
              color: context.blackColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _periodCard(
                title: 'صباحاً',
                timeRange: '10:00 ص - 1:30 م',
                periodKey: 'morning',
                context: context,
              ),
              const SizedBox(width: 12),
              _periodCard(
                title: 'مساءً',
                timeRange: '4:00 م - 8:30 م',
                periodKey: 'evening',
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _periodCard({
    required String title,
    required String timeRange,
    required String periodKey,
    required BuildContext context,
  }) {
    final isSelected = selectedPeriodKey == periodKey;
    final bgColor = isSelected ? context.primaryColor : context.gray300Color;
    final textColor = isSelected ? context.whiteColor : context.blackColor;
    final borderColor = isSelected
        ? context.primaryColor
        : context.gray200Color;

    return Expanded(
      child: GestureDetector(
        onTap: () => onPeriodSelected(periodKey),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          height: 72,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: context.primaryColor.withValues(alpha: 0.24),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: FontStyles.subTitle2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timeRange,
                  style: FontStyles.body2.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
