import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/chart_column.dart';
import 'package:flutter/material.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(child: Column(children: [
        
     Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            // Color(0xFF1B1F3B),
            // Color(0xFF2A2F5E),
            AppColors.primary,
            Color.fromARGB(255, 27, 38, 74),
            Color.fromARGB(255, 13, 13, 14)
          ],
          begin: Alignment.topCenter,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Column(children: [
                Text(
                "إجمالي الحجوزات :",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                ),
              ),
               Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "(124)",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "حجز",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
              ],),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7,top: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                              children:[
                                ChartColumn(coulmnHeight: 50),
                                SizedBox(width: 6,),
                                ChartColumn(coulmnHeight: 35),
                                SizedBox(width: 6,),
                                ChartColumn(coulmnHeight: 45),
                                SizedBox(width: 6,),
                                ChartColumn(coulmnHeight: 25),
                                SizedBox(width: 6,),
                                ChartColumn(coulmnHeight: 40),
                                SizedBox(width: 6,),
                                ChartColumn(coulmnHeight: 60),
                                SizedBox(width: 6,),
                                ChartColumn(coulmnHeight: 45),
                              ] 
                            ),
                ),
              ],)
              
              
            ],
          ),

          
         
          
        ],
      ),
    )
 
      ],)),
        ),
      ],
    );
  }
}


