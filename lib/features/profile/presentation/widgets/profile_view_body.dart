import 'package:doctor_booking_system_with_ai/core/manager/profile/profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/widgets/profile_summary.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/widgets/user_account_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (BuildContext context, state) {
                    if (state is ProfileSuccess) {
                      return ProfileSummary(
                        name: state.profile.user.name,
                        userImage: state.profile.profileImage!,
                        phoneNumber: state.profile.phone,
                      );
                    }
                    if (state is ProfileFailure) {
                      return Text(state.errorMessage);
                    } else {
                      return const CustomLoader(loaderSize: kLoaderSize);
                    }
                  },
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
