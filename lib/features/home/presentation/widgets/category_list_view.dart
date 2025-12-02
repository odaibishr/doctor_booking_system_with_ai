import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/category_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialtyCubit, SpecialtyState>(
      builder: (BuildContext context, state) {
        if (state is SpecialtyLoaded) {
          final activeSpecialties = state.specialties
              .where((specialty) => specialty.isActive)
              .toList();
          return SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activeSpecialties.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CategoryCard(
                    color: false,
                    title: activeSpecialties[index].name,
                    icon: activeSpecialties[index].icon,
                  ),
                );
              },
            ),
          );
        }
        if (state is SpecialtyError) {
          return Center(
            child: Text(
              state.message,
              style: FontStyles.body3.copyWith(color: AppColors.gray500),
            ),
          );
        } else {
          return const CustomLoader(loaderSize: kLoaderSize);
        }
      },
    );
  }
}
