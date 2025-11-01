import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class TimePeriodSelector extends StatefulWidget {
  final ValueChanged<String>? onPeriodSelected;

  const TimePeriodSelector({super.key, this.onPeriodSelected});

  @override
  State<TimePeriodSelector> createState() => _TimePeriodSelectorState();
}

class _TimePeriodSelectorState extends State<TimePeriodSelector> {
  String _selectedPeriod = ''; 

  void _selectPeriod(String period) {
    setState(() {
      _selectedPeriod = period;
    });
    widget.onPeriodSelected?.call(period);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray300.withValues(alpha: 255),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'اختر الفترة',
            style: FontStyles.headLine4.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _periodCard(
                title: 'صباحية',
                timeRange: '10:00 ص - 1:30 م',
                periodKey: 'صباحية',
              ),
              const SizedBox(width: 12),
              _periodCard(
                title: 'مسائية',
                timeRange: '4:00 م - 8:30 م',
                periodKey: 'مسائية',
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
  }) {
    final isSelected = _selectedPeriod == periodKey;
    final bgColor = isSelected
        ? AppColors.primary
        : (periodKey == 'صباحية' ? AppColors.gray300 : AppColors.gray200);
    final textColor = isSelected
        ? AppColors.white
        : (periodKey == 'صباحية' ? AppColors.primary : AppColors.black);

    return Expanded(
      child: GestureDetector(
        onTap: () => _selectPeriod(periodKey),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: bgColor.withValues(alpha: 0.25),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
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
