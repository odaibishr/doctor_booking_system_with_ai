import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/manager/search_doctors_cubit/search_doctors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'gender_filter_section.dart';
import 'price_range_filter_section.dart';
import 'specialty_filter_section.dart';

class FilterBottomSheetContent extends StatefulWidget {
  const FilterBottomSheetContent({super.key});

  @override
  State<FilterBottomSheetContent> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<FilterBottomSheetContent> {
  String? _selectedGender;
  int? _selectedSpecialtyId;
  final double _minPrice = 0;
  final double _maxPrice = 15000;
  RangeValues _priceRange = const RangeValues(0, 15000);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.gray300Color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تصفية البحث',
                  style: FontStyles.subTitle1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: _resetFilters,
                  child: Text(
                    'إعادة تعيين',
                    style: FontStyles.body1.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            GenderFilterSection(
              selectedGender: _selectedGender,
              onGenderChanged: (value) =>
                  setState(() => _selectedGender = value),
            ),

            const SizedBox(height: 20),

            SpecialtyFilterSection(
              selectedSpecialtyId: _selectedSpecialtyId,
              onSpecialtyChanged: (value) =>
                  setState(() => _selectedSpecialtyId = value),
            ),

            const SizedBox(height: 20),

            PriceRangeFilterSection(
              priceRange: _priceRange,
              minPrice: _minPrice,
              maxPrice: _maxPrice,
              onPriceRangeChanged: (values) =>
                  setState(() => _priceRange = values),
            ),

            const SizedBox(height: 24),
            MainButton(
              text: 'تطبيق الفلاتر',
              onTap: () {
                context.read<SearchDoctorsCubit>().applyFilters(
                  gender: _selectedGender,
                  specialtyId: _selectedSpecialtyId,
                  minPrice: _priceRange.start > _minPrice
                      ? _priceRange.start
                      : null,
                  maxPrice: _priceRange.end < _maxPrice
                      ? _priceRange.end
                      : null,
                );
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _selectedGender = null;
      _selectedSpecialtyId = null;
      _priceRange = RangeValues(_minPrice, _maxPrice);
    });
  }
}
