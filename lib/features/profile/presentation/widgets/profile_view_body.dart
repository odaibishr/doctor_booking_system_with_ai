import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/widgets/profile_summary.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/widgets/user_account_menu.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: CustomAppBar(
            userImage: 'assets/images/my-photo.jpg',
            title: 'الحساب الشخصي',
            isBackButtonVisible: false,
            isUserImageVisible: false,
          ),
          pinned: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                const SizedBox(height: 30),
                ProfileSummary(
                  name: 'عدي بشر',
                  userImage: 'assets/images/my-photo.jpg',
                  phoneNumber: '967774536599+',
                ),
                const SizedBox(height: 30),
                const UserAccountMenu(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
