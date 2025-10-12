import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class FilterSearch extends StatelessWidget {
  const FilterSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 48,
        height: 48,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          'assets/icons/filter.svg',
          width: 24,
          height: 24,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
