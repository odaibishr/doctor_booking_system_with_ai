import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/app_navigation.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/modern_nav_bar_painter.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/dashboard_view.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/home_page_view.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/profilee_view.dart';
import 'package:flutter/material.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({super.key});

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  final List<Widget> _pages = [ DashboardView(),HomePageView(), ProfileeView()];
  int currentindex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentindex],
       extendBody: true,
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: currentindex,
         height: 10,
       // indicatorColor: Colors.blue,
        unselectedItemColor: AppColors.gray300,
        enablePaddingAnimation: EditableText.defaultStylusHandwritingEnabled,
        curve: Curves.linear,
        
        borderWidth: 0,
        outlineBorderColor: Colors.white,
        backgroundColor: AppColors.primary,
        onTap: (index){
          setState(() {
            currentindex=index;
          });
        },
        items: [
           CrystalNavigationBarItem(

            icon: Icons.dashboard,
            selectedColor: Colors.white,
            
          ),
          CrystalNavigationBarItem(
            icon: Icons.home,
            selectedColor: Colors.white,

            badge: Badge(
              backgroundColor: AppColors.gray100,
              label: Text(
                "15",
                style: TextStyle(color:AppColors.primaryColor),
              ),
            ),
          ),
          CrystalNavigationBarItem(
            icon: Icons.person,
            selectedColor: Colors.white,
            
          ),
        ]
      ),
    );
  }
}
