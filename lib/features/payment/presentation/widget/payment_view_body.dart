import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/doctor_info.dart';
import 'package:flutter/material.dart';

class PaymentViewBody extends StatelessWidget {
  const PaymentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: CustomAppBar(
            title: 'الدفع',
            isBackButtonVisible: true,
            isUserImageVisible: false,
          ),
          pinned: true,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          automaticallyImplyLeading: false,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const DoctorInfo(
                  name: 'د. صادق محمد بشر',
                  specialization: 'مخ واعصاب',
                  location: 'مستشفئ جامعة العلوم والتكنولوجيا',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
