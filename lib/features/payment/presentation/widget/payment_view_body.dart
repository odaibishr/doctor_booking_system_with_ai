import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/doctor_info.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_method_item.dart';
import 'package:flutter/material.dart';

class PaymentViewBody extends StatefulWidget {
  const PaymentViewBody({super.key});

  @override
  State<PaymentViewBody> createState() => _PaymentViewBodyState();
}

class _PaymentViewBodyState extends State<PaymentViewBody> {
  int selectedMethodIndex = 0;

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
                const SizedBox(height: 28),
                Text(
                  'طريقة الدفع',
                  style: FontStyles.subTitle3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PaymentMethodItem(
                      label: 'Cash',
                      iconPath: 'assets/icons/pay-card.svg',
                      isSelected: selectedMethodIndex == 0,
                      onTap: () {
                        setState(() {
                          selectedMethodIndex = 0;
                        });
                      },
                    ),
                    PaymentMethodItem(
                      label: 'Cash',
                      iconPath: 'assets/icons/cash.svg',
                      isSelected: selectedMethodIndex == 1,
                      onTap: () {
                        setState(() {
                          selectedMethodIndex = 1;
                        });
                      },
                    ),
                    PaymentMethodItem(
                      label: 'Card',
                      iconPath: 'assets/icons/pay-card.svg',
                      isSelected: selectedMethodIndex == 2,
                      onTap: () {
                        setState(() {
                          selectedMethodIndex = 2;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                MainInputField(
                  hintText: 'رقم البطاقة',
                  leftIconPath: 'assets/icons/pay-card.svg',
                  rightIconPath: 'assets/icons/edit-2.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
