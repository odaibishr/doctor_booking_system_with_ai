import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/categorys/presention/widget/category_graide.dart';
import 'package:flutter/material.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {'title': 'مخ واعصاب', 'icon': 'assets/icons/brain.svg'},
      {'title': 'القلب', 'icon': 'assets/icons/Cardiolo.svg'},
      {'title': 'الباطنة', 'icon': 'assets/icons/Gastroen.svg'},
      {'title': 'الاسنان', 'icon': 'assets/icons/dentist.svg'},
      {'title': 'اللقاح', 'icon': 'assets/icons/Vaccinat.svg'},
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: CustomAppBar(
              title: 'التخصصات',
              isBackButtonVisible: true,
              isUserImageVisible: false,
            ),
          ),
          SliverToBoxAdapter(
            child: CategoryGride(categories: categories),
          ),
        ],
      ),
    );
  }
}


