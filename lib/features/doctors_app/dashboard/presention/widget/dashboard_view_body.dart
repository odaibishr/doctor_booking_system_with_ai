import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/balance_card.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/choice_item.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/doctor_card.dart';
import 'package:flutter/material.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key});

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  int _selectedChoice = 0;
  final List<String> _choices = ['الكل', 'يومي', 'اسبوعي', 'شهري'];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const BalanceCard(),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(
                    _choices.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: ChoiceItem(
                        title: _choices[index],
                        isSelected: _selectedChoice == index,
                        onTap: () => setState(() => _selectedChoice = index),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        DoctorCard(
                          cardIcon: Icons.people_alt_outlined,
                          cardTitle: 'عدد المرضى',
                          cardContent: '240',
                        ),
                        DoctorCard(
                          cardIcon: Icons.history_rounded,
                          cardTitle: 'مراجعات',
                          cardContent: '45',
                          iconColor: Colors.orange,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        DoctorCard(
                          cardIcon: Icons.local_hospital_outlined,
                          cardTitle: 'المستشفى',
                          cardContent: 'سيبلاس',
                          iconColor: Colors.blue,
                        ),
                        DoctorCard(
                          cardIcon: Icons.cancel_outlined,
                          cardTitle: 'حجوزات ملغية',
                          cardContent: '12',
                          iconColor: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        DoctorCard(
                          cardIcon: Icons.access_time_rounded,
                          cardTitle: 'ساعات الدوام',
                          cardContent: '8 ص - 2 م',
                          iconColor: Colors.green,
                        ),
                        DoctorCard(
                          cardIcon: Icons.event_busy_rounded,
                          cardTitle: 'أيام الإجازة',
                          cardContent: 'الجمعة',
                          iconColor: Colors.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ],
    );
  }
}
