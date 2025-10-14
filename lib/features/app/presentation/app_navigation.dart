import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/floating_middle_button.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/modern_nav_bar_painter.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/nav_item.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/booking_history_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/home_view.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/search_view.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    SearchView(),
    BookingHistoryView(),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],

      floatingActionButton: FloatingMiddleButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        height: 70,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF364989).withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 70),
              painter: ModernNavBarPainter(),
            ),
            Padding(
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
                    icon: 'assets/icons/search.svg',
                    index: 1,
                    selectedIndex: _selectedIndex,
                    onItemTapped: _onItemTapped,
                  ),
                  const SizedBox(width: 50), // مساحة للـ FAB
                  NavItem(
                    icon: 'assets/icons/calendar.svg',
                    index: 2,
                    selectedIndex: _selectedIndex,
                    onItemTapped: _onItemTapped,
                  ),
                  NavItem(
                    icon: 'assets/icons/user.svg',
                    index: 3,
                    selectedIndex: _selectedIndex,
                    onItemTapped: _onItemTapped,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
