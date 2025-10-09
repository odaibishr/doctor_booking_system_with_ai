import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const CustomHomeAppBar(
                name: 'مرحبًا عدي',
                userImage: 'assets/images/my-photo.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
