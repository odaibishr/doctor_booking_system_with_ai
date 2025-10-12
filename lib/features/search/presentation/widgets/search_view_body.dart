import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
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
                title: 'كل الأطباء',
                isBackButtonVisible: true,
                isUserImageVisible: true,
              ),
              const SizedBox(height: 16),
              const MainInputField(
                hintText: 'بحث',
                leftIconPath: 'assets/icons/search.svg',
                rightIconPath: 'assets/icons/user.svg',
                isShowRightIcon: true,
                isShowLeftIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
