import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/widgets/profile_summary.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          CustomAppBar(
            userImage: 'assets/images/my-photo.jpg',
            title: 'الحساب الشخصي',
            isBackButtonVisible: false,
            isUserImageVisible: false,
          ),
          const SizedBox(height: 30),
          ProfileSummary(
            name: 'عدي بشر',
            userImage: 'assets/images/my-photo.jpg',
            phoneNumber: '967774536599+',
          ),
        ],
      ),
    );
  }
}
