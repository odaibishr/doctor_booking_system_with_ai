import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class DoctorInformationCard extends StatelessWidget {
  const DoctorInformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container( width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/6,
        padding: EdgeInsets.all(12),
       margin: EdgeInsets.only(bottom: 10),
           
     decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
       color: const Color.fromARGB(255, 255, 255, 255)
      
          ),
          child: Row(children: [
        Container(
    width:93,
        height: 93,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(100))
    ),
    child: Image.asset('assets/images/profile_image.png',
           )),
           SizedBox(width: 25,),
           Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 10,),
        Row(
    children: [
      Icon(Icons.person),
      SizedBox(width: 5,),
      Text('احمد مختار ',style: TextStyle(color: AppColors.primaryColor),),
    ],
        ), 
        SizedBox(height: 10,),
     Row(
    children: [
      Icon(Icons.av_timer),
      SizedBox(width: 5,),
      Text('8:00-10:00',style: TextStyle(color: AppColors.primaryColor),),
    ],
        ),
        SizedBox(height: 8,),
        Row(
    children: [
    GestureDetector(
      child: Container(padding: EdgeInsets.only(top: 7,bottom: 7,right: 80,left: 80),
        child: Text('تفاصيل',style: TextStyle(color: AppColors.white),),
        decoration: BoxDecoration(
          color:AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(24)) 
        ),
        ),
    ),
    SizedBox(width: 5,),
          
        ],),
           ],)
          ],),);
  }
}