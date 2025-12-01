import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/category_card.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  List<Map<String, String>> categories = [
    {'title': 'مخ واعصاب', 'icon': 'assets/icons/brain.svg'},
    {'title': 'القلب', 'icon': 'assets/icons/Cardiolo.svg'},
    {'title': 'الباطنة', 'icon': 'assets/icons/Gastroen.svg'},
    {'title': 'الاسنان', 'icon': 'assets/icons/dentist.svg'},
    {'title': 'اللقاح', 'icon': 'assets/icons/Vaccinat.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CategoryCard(
              color: false,
              title: categories[index]['title']!,
              icon: categories[index]['icon']!,
            ),
          );
        },
      ),
    );
  }
}
