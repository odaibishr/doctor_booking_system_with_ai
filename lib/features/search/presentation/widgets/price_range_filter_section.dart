import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class PriceRangeFilterSection extends StatelessWidget {
  const PriceRangeFilterSection({
    super.key,
    required this.priceRange,
    required this.minPrice,
    required this.maxPrice,
    required this.onPriceRangeChanged,
  });

  final RangeValues priceRange;
  final double minPrice;
  final double maxPrice;
  final ValueChanged<RangeValues> onPriceRangeChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نطاق السعر',
          style: FontStyles.subTitle3.copyWith(
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${priceRange.start.toInt()} د.ع',
              style: FontStyles.body2.copyWith(
                color: context.textSecondaryColor,
              ),
            ),
            Text(
              '${priceRange.end.toInt()} د.ع',
              style: FontStyles.body2.copyWith(
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: priceRange,
          min: minPrice,
          max: maxPrice,
          divisions: 50,
          activeColor: AppColors.primary,
          inactiveColor: isDark ? AppColors.gray300Dark : AppColors.gray200,
          onChanged: onPriceRangeChanged,
        ),
      ],
    );
  }
}
