import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/doctor_header_section.dart';
import 'package:flutter/material.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          CustomAppBar(
            userImage: 'assets/images/user.png',
            title: 'معلومات الطبيب',
            isBackButtonVisible: true,
            isUserImageVisible: false,
            isHeartIconVisible: true,
          ),
          const SizedBox(height: 30),
          DoctorHeaderSection(
            doctorName: 'د. صادق محمد بشر',
            doctorSpecializatioin: 'مخ واعصاب',
            doctorLocation: 'مستشفئ جامعة العلوم والتكنولوجيا',
            doctorImage: 'assets/images/doctor-image.png',
          ),
        ],
      ),
    );
  }
}
