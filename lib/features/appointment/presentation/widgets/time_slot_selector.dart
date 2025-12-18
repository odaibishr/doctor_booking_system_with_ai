import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class TimeSlotSelector extends StatelessWidget {
  const TimeSlotSelector({
    super.key,
    required this.slots,
    required this.selectedSlot,
    required this.onSelected,
    this.disabledSlots = const {},
  });

  final List<String> slots;
  final String? selectedSlot;
  final ValueChanged<String> onSelected;
  final Set<String> disabledSlots;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: slots.map((slot) {
        final isDisabled = disabledSlots.contains(slot);
        final isSelected = selectedSlot == slot;

        final bgColor =
            isSelected
                ? AppColors.primary
                : isDisabled
                ? AppColors.gray300
                : AppColors.white;
        final borderColor =
            isSelected ? AppColors.primary : AppColors.gray200;
        final textColor =
            isSelected ? AppColors.white : AppColors.black;

        return InkWell(
          onTap: isDisabled ? null : () => onSelected(slot),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.22),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              slot,
              style: FontStyles.subTitle3.copyWith(
                color: isDisabled ? AppColors.gray500 : textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

