import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/category_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_booking_system_with_ai/core/utils/responsive.dart';

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
            height: Responsive.isDesktop(context) ? 130 : 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activeSpecialties.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CategoryCard(
                    color: false,
                    id: activeSpecialties[index].id,
                    title: activeSpecialties[index].name,
                    icon: activeSpecialties[index].icon,
                    width: Responsive.isDesktop(context) ? 120 : 85,
                    height: Responsive.isDesktop(context) ? 120 : 85,
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
          return SizedBox(
            height: Responsive.isDesktop(context) ? 130 : 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) => Column(
                children: [
                   CustomShimmer.circular(width: 50, height: 50),
                   SizedBox(height: 8),
                   CustomShimmer.rectangular(width: 40, height: 10),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
