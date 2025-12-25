import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/floating_middle_button.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/modern_nav_bar_painter.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/nav_item.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/booking_history_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/home_view.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/profile_view.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/search_view.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatefulWidget {
  final int initialIndex;
  const AppNavigation({super.key, this.initialIndex = 0});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    HomeView(),
    SearchView(),
    BookingHistoryView(),
    ProfileView(),
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
    return Scaffold(
      extendBody: true,
      body: _pages[safeIndex],

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
                  const SizedBox(width: 50),
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
