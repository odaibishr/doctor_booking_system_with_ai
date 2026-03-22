import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';

import 'filter_chip_widget.dart';

class SpecialtyFilterSection extends StatelessWidget {
  const SpecialtyFilterSection({
    super.key,
    required this.selectedSpecialtyId,
    required this.onSpecialtyChanged,
  });

  final int? selectedSpecialtyId;
  final ValueChanged<int?> onSpecialtyChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التخصص',
          style: FontStyles.subTitle3.copyWith(
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<SpecialtyCubit, SpecialtyState>(
          builder: (context, state) {
            if (state is! SpecialtyLoaded) {
              return const SizedBox.shrink();
            }

            final specialties = state.specialties;
            return SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: specialties.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return FilterChipWidget(
                      label: 'الكل',
                      isSelected: selectedSpecialtyId == null,
                      onTap: () => onSpecialtyChanged(null),
                    );
                  }
                  final specialty = specialties[index - 1];
                  return FilterChipWidget(
                    label: specialty.name,
                    isSelected: selectedSpecialtyId == specialty.id,
                    onTap: () => onSpecialtyChanged(specialty.id),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
