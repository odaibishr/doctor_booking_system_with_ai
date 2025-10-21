import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/tap_bar.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_header_section.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_stats_section.dart';
import 'package:flutter/material.dart';

class HospitalDetailsViewBody extends StatefulWidget {
  const HospitalDetailsViewBody({super.key});

  @override
  State<HospitalDetailsViewBody> createState() =>
      _HospitalDetailsViewBodyState();
}

class _HospitalDetailsViewBodyState extends State<HospitalDetailsViewBody> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: 'معلومات المستشفى',
            isBackButtonVisible: true,
            isUserImageVisible: false,
            isHeartIconVisible: false,
          ),
          const SizedBox(height: 28),
          HospitalHeaderSection(
            hospitalName: 'مستشفى جامعة العلوم والتكنولوجيا',
            hospitalLocation: 'صنعاء . شارع الستين . جسر مذبح',
            hospitalImage: 'assets/images/hospital.jpg',
          ),
          const SizedBox(height: 20),
          const HospitalStatsSection(),
          const SizedBox(height: 30),
          TapBar(
            tabItems: ['عنا', 'المتخصصون', 'المراجعات'],
            selectedTab: _selectedTab,
            onTabChanged: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
          ),

          
        ],
      ),
    );
  }
}
