import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ChoiceItem extends StatelessWidget {
  final String title;
  const ChoiceItem({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
      child: Text(title,style: TextStyle(color: AppColors.textPrimaryDark),),decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(24))
    ),);
  }
}
