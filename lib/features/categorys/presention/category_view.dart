import 'package:doctor_booking_system_with_ai/features/categorys/presention/widget/category_body.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: CategoryBody()));
  }
}