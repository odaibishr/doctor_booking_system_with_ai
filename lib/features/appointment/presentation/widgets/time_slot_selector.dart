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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final isDisabled = disabledSlots.contains(slot);
        final isSelected = selectedSlot == slot;

        final bgColor = isSelected
            ? AppColors.getPrimary(context)
            : isDisabled
            ? AppColors.getGray300(context)
            : AppColors.getCard(context);
        final borderColor = isSelected
            ? AppColors.getPrimary(context)
            : AppColors.getGray200(context);
        final textColor = isSelected
            ? AppColors.white
            : AppColors.getTextPrimary(context);

        return InkWell(
          onTap: isDisabled ? null : () => onSelected(slot),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.getPrimary(
                          context,
                        ).withValues(alpha: 0.22),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              slot,
              style: FontStyles.subTitle3.copyWith(
                color: isDisabled ? AppColors.getGray500(context) : textColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
