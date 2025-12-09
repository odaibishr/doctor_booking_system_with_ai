import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/tap_bar.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_header_section.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_stats_section.dart';
import 'package:flutter/material.dart';
import 'hospital_details_about_tab.dart';
import 'hospital_details_doctors_tab.dart';
import 'hospital_details_reviews_tab.dart';

class HospitalDetailsViewBody extends StatefulWidget {
  const HospitalDetailsViewBody({super.key});

  @override
  State<HospitalDetailsViewBody> createState() =>
      _HospitalDetailsViewBodyState();
}

class _HospitalDetailsViewBodyState extends State<HospitalDetailsViewBody> {
  int _selectedTab = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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

            // 🔵 TapBar يعمل مع PageView
            TapBar(
              tabItems: ['عنا', 'المتخصصون', 'المراجعات'],
              selectedTab: _selectedTab,
              onTabChanged: (index) {
                setState(() => _selectedTab = index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),

            const SizedBox(height: 20),

            // 🔵 PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _selectedTab = index);
                },
                children: [
                  HospitalDetailsAboutTab(
                    doctors: _doctors,
                    reviews: _reviews,
                  ),
                  HospitalDetailsDoctorsTab(doctors: _doctors),
                  HospitalDetailsReviewsTab(reviews: _reviews),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // بيانات المستشفى
  final List<Map<String, dynamic>> _doctors = [
    {
      'id': '1',
      'name': 'د. أحمد محمد',
      'specialization': 'جراحة عامة',
      'rating': 4.8,
      'experience': '5 سنوات',
    },
    {
      'id': '2',
      'name': 'د. فاطمة عبدالله',
      'specialization': 'طب الأطفال',
      'rating': 4.9,
      'experience': '7 سنوات',
    },
    {
      'id': '3',
      'name': 'د. ياسر علي',
      'specialization': 'القلب والأوعية',
      'rating': 4.7,
      'experience': '10 سنوات',
    },
  ];

  final List<Map<String, dynamic>> _reviews = [
    {
      'id': '1',
      'name': 'عدي جلال بشر',
      'rating': '4.5',
      'review':
          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
    },
    {
      'id': '2',
      'name': 'سارة أحمد',
      'rating': '4.8',
      'review': 'خدمة ممتازة وطاقم طبي محترف، شكراً للعناية المميزة',
    },
    {
      'id': '3',
      'name': 'محمد عبدالرحمن',
      'rating': '4.2',
      'review': 'تجربة جيدة بشكل عام، ولكن يمكن تحسين وقت الانتظار',
    },
  ];
}
