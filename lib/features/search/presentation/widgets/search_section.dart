import 'package:doctor_booking_system_with_ai/features/search/presentation/manager/search_doctors_bloc/search_doctors_bloc.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/filter_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
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
            onChanged: (value) {
              context.read<SearchDoctorsBloc>().add(
                SearchDoctorsQueryChanged(value),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        const FilterSearch(),
      ],
    );
  }
}
