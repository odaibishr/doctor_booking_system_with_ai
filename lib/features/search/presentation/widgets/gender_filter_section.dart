import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

import 'filter_chip_widget.dart';

class GenderFilterSection extends StatelessWidget {
  const GenderFilterSection({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  final String? selectedGender;
  final ValueChanged<String?> onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الجنس',
          style: FontStyles.subTitle3.copyWith(
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            FilterChipWidget(
              label: 'الكل',
              isSelected: selectedGender == null,
              onTap: () => onGenderChanged(null),
            ),
            const SizedBox(width: 8),
            FilterChipWidget(
              label: 'ذكر',
              isSelected: selectedGender == 'Male',
              onTap: () => onGenderChanged('Male'),
            ),
            const SizedBox(width: 8),
            FilterChipWidget(
              label: 'أنثى',
              isSelected: selectedGender == 'Female',
              onTap: () => onGenderChanged('Female'),
            ),
          ],
        ),
      ],
    );
  }
}
