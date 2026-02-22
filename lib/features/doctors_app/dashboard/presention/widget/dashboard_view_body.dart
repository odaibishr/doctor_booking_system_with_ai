import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/balance_card.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/chart_column.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/choice_item.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/doctor_card.dart';
import 'package:flutter/material.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
            child: Container(child: Column(children: [
                BalanceCard(),//top card
                 SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ChoiceItem(title: 'الكل',),
                      ChoiceItem(title: 'يومي',),
                      ChoiceItem(title: 'اسبوعي',),
                      ChoiceItem(title: 'شهري',),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DoctorCard(CardHeight: 100, Cardwidth: 160, CardIcon: Icons.person, CardTitle: '  عدد المرضى', CardContent: '(20)',),
                    DoctorCard(CardHeight: 100, Cardwidth: 160, CardIcon: Icons.timelapse, CardTitle: '      عودة', CardContent: '(20)',),
                  ],
                ),
                SizedBox(height: 14,),
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DoctorCard(CardHeight: 100, Cardwidth: 160, CardIcon: Icons.local_hospital_rounded, CardTitle: '  المستشفى', CardContent: '(سيبلاس)',),
                    DoctorCard(CardHeight: 100, Cardwidth: 160, CardIcon:Icons.cancel, CardTitle:'      ملغية', CardContent: '(30)',),
                  ],
                ),
                SizedBox(height: 14,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DoctorCard(CardHeight: 100, Cardwidth: 160, CardIcon:Icons.timer_rounded, CardTitle:' ساعات الدوام', CardContent: '8:00-12:00',),
                    DoctorCard(CardHeight: 100, Cardwidth: 160, CardIcon:Icons.holiday_village_rounded, CardTitle:'    أيام الاجازة', CardContent: 'Sat,Mon...',),
                  ],
                )
                
             
                  ],)),
          ),
        ),
      ],
    );
  }
}




