import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              CustomAppBar(
                userImage: 'assets/images/my-photo.jpg',
                title: 'بحث',
                isBackButtonVisible: true,
                isUserImageVisible: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
