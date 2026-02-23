import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/nav_item.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/dashboard_view.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/home_page_view.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/profilee_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:flutter/material.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({super.key});

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardView(),
    const HomePageView(),
    const ProfileeView(),
  ];

  void _onItemTapped(int index) {
    if (!mounted) return;
    if (index < 0 || index >= _pages.length) return;
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final safeIndex = (_selectedIndex >= 0 && _selectedIndex < _pages.length)
        ? _selectedIndex
        : 0;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      extendBody: true,
      appBar: safeIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              surfaceTintColor: Colors.transparent,
              title: CustomHomeAppBar(
                name: '',
                userImage: 'assets/images/my-photo.jpg',
              ),
            )
          : null,
      body: _pages[safeIndex],
      bottomNavigationBar: isKeyboardVisible
          ? null
          : Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF364989),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF364989).withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavItem(
                      icon: 'assets/icons/home.svg',
                      index: 0,
                      selectedIndex: _selectedIndex,
                      onItemTapped: _onItemTapped,
                    ),
                    NavItem(
                      icon: 'assets/icons/calendar.svg',
                      index: 1,
                      selectedIndex: _selectedIndex,
                      onItemTapped: _onItemTapped,
                    ),
                    NavItem(
                      icon: 'assets/icons/user.svg',
                      index: 2,
                      selectedIndex: _selectedIndex,
                      onItemTapped: _onItemTapped,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
