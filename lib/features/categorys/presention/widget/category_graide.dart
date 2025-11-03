import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryGride extends StatelessWidget {
  const CategoryGride({
    super.key,
    required this.categories,
  });

  final List<Map<String, String>> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
      child: GridView.builder(
        shrinkWrap: true, // ✅ مهم جدًا
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              
            },
            child: CategoryCard(
              title: categories[index]['title'].toString(),
              icon: categories[index]['icon'].toString(),
            ),
          );
        },
      ),
    );
  }
}