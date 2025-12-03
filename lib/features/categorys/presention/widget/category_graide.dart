import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryGride extends StatelessWidget {
  const CategoryGride({super.key, required this.specialties});

  final List<Specialty> specialties;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.searchViewRoute);
            },
            child: CategoryCard(
              color: true,
              title: specialties[index].name,
              icon: specialties[index].icon,
            ),
          );
        },
      ),
    );
  }
}
