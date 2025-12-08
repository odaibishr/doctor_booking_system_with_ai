import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/search_doctor_list_view.dart';
import 'package:flutter/material.dart';

class FavoriteDoctorBody extends StatelessWidget {
  const FavoriteDoctorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          CustomAppBar(
            title: 'المفضلة',
            isBackButtonVisible: true,
            isUserImageVisible: false,
          ),
          SizedBox(height: 30),
          Expanded(child: ),
        ],
      ),
    );
  }
}
