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
      padding: EdgeInsets.only(top: 10,left: 2,right: 2),
      height: CardHeight,
      width: Cardwidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            // Color(0xFF1B1F3B),
            // Color(0xFF2A2F5E),
            AppColors.gray300,
            AppColors.gray100,
            
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
          
          
          
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    child: Column(children: [
      Row(children: [
        Icon(CardIcon,size: 40,),
        Text(CardTitle,style: TextStyle(fontSize: 17,color: AppColors.primaryColor),)

      ],),
      SizedBox(height: 20,)
      ,Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(CardContent,style: TextStyle(fontSize: 25,color: AppColors.primaryColor),)
      ],)
    ],),);
  }
}