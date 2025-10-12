import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/filter_search.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MainInputField(
            hintText: 'بحث',
            leftIconPath: 'assets/icons/search.svg',
            rightIconPath: 'assets/icons/user.svg',
            isShowRightIcon: true,
            isShowLeftIcon: false,
          ),
        ),
        const SizedBox(width: 10),
        const FilterSearch(),
      ],
    );
  }
}
