import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/balance_card.dart';
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
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Column(
              children: [
                const BalanceCard(),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      ChoiceItem(title: 'الكل'),
                      ChoiceItem(title: 'يومي'),
                      ChoiceItem(title: 'اسبوعي'),
                      ChoiceItem(title: 'شهري'),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    DoctorCard(
                      CardHeight: 100,
                      Cardwidth: 160,
                      CardIcon: Icons.person,
                      CardTitle: '  عدد المرضى',
                      CardContent: '(20)',
                    ),
                    DoctorCard(
                      CardHeight: 100,
                      Cardwidth: 160,
                      CardIcon: Icons.timelapse,
                      CardTitle: '      عودة',
                      CardContent: '(20)',
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    DoctorCard(
                      CardHeight: 100,
                      Cardwidth: 160,
                      CardIcon: Icons.local_hospital_rounded,
                      CardTitle: '  المستشفى',
                      CardContent: '(سيبلاس)',
                    ),
                    DoctorCard(
                      CardHeight: 100,
                      Cardwidth: 160,
                      CardIcon: Icons.cancel,
                      CardTitle: '      ملغية',
                      CardContent: '(30)',
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    DoctorCard(
                      CardHeight: 100,
                      Cardwidth: 160,
                      CardIcon: Icons.timer_rounded,
                      CardTitle: ' ساعات الدوام',
                      CardContent: '8:00-12:00',
                    ),
                    DoctorCard(
                      CardHeight: 100,
                      Cardwidth: 160,
                      CardIcon: Icons.holiday_village_rounded,
                      CardTitle: '    أيام الاجازة',
                      CardContent: 'Sat,Mon...',
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
