import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final double CardHeight;
  final double Cardwidth;
  final IconData CardIcon;
  final String CardTitle;
  final String CardContent;
  const DoctorCard({
    super.key, required this.CardHeight, required this.Cardwidth, required this.CardIcon, required this.CardTitle, required this.CardContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10,left: 2,right: 8),
      height: CardHeight,
      width: Cardwidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      color: AppColors.gray100
      ),
    child: Column(children: [
      Row(children: [
        Icon(CardIcon,size: 25,),
        Text(CardTitle,style: TextStyle(fontSize: 16,color: AppColors.primaryColor),)

      ],),
      SizedBox(height: 20,)
      ,Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(CardContent,style: TextStyle(fontSize: 18,color: AppColors.primaryColor),)
      ],)
    ],),);
  }
}