import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/tap_bar.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/cancelled_appointment_page.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/next_appintment_page.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/previous_appointment_page.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/waitlist_appointment_page.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/appointments/doctor_appointments_cubit.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageViewBody extends StatefulWidget {
  const HomePageViewBody({super.key});

  @override
  State<HomePageViewBody> createState() => _HomePageViewBodyState();
}

class _HomePageViewBodyState extends State<HomePageViewBody> {
  int _selectedTab = 0;
  final PageController _pageController = PageController();

  void _onTabChanged(int index) {
    setState(() => _selectedTab = index);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageSwiped(int index) {
    setState(() => _selectedTab = index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        children: [
          const CustomAppBar(
            userImage: 'assets/images/my-photo.jpg',
            title: 'الحجوزات',
            isBackButtonVisible: false,
            isUserImageVisible: true,
          ),
          const SizedBox(height: 16),
          TapBar(
            tabItems: const [
              'قائمة الانتظار',
              'القادمة',
              'المكتملة',
              'الملغاة',
            ],
            selectedTab: _selectedTab,
            onTabChanged: _onTabChanged,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageSwiped,
              children: [
                BlocProvider(
                  create: (_) =>
                      serviceLocator<DoctorAppointmentsCubit>()
                        ..fetchAppointmentsByStatus('pending'),
                  child: const WaitlistAppointmentPage(),
                ),
                BlocProvider(
                  create: (_) =>
                      serviceLocator<DoctorAppointmentsCubit>()
                        ..fetchAppointmentsByStatus('confirmed'),
                  child: const NextAppintmentPage(),
                ),
                BlocProvider(
                  create: (_) =>
                      serviceLocator<DoctorAppointmentsCubit>()..fetchHistory(),
                  child: const PreviousAppointmentPage(),
                ),
                BlocProvider(
                  create: (_) =>
                      serviceLocator<DoctorAppointmentsCubit>()
                        ..fetchAppointmentsByStatus('cancelled'),
                  child: const CancelledAppointmentPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
