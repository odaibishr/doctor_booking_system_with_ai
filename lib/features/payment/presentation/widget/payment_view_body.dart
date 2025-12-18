import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/jaib_show_dialog.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/appointment_details.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/doctor_info.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_method_item.dart';
import 'package:flutter/material.dart';

class PaymentViewBody extends StatefulWidget {
  final bool? completePayment;
  final VoidCallback onpres;

  const PaymentViewBody({
    super.key,
    this.completePayment,
    required this.onpres,
  });

  @override
  State<PaymentViewBody> createState() => _PaymentViewBodyState();
}

class _PaymentViewBodyState extends State<PaymentViewBody> {
  late bool completePayment;

  @override
  void initState() {
    super.initState();
    completePayment = widget.completePayment ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: screen.height * 0.02),

        const CustomAppBar(
          title: 'الدفع',
          isBackButtonVisible: true,
          isUserImageVisible: false,
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screen.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screen.height * 0.02),

                const DoctorInfo(
                  name: 'د. صادق محمد بشر',
                  specialization: 'مخ واعصاب',
                  location: 'مستشفئ جامعة العلوم والتكنولوجيا',
                ),

                SizedBox(height: screen.height * 0.03),

                Text(
                  'طريقة الدفع',
                  style: FontStyles.subTitle3.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screen.width * 0.045,
                  ),
                ),

                SizedBox(height: screen.height * 0.015),

                PaymentMethodItem(
                  label: '',
                  iconPath: 'assets/images/jaib.svg',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => JaibShowDialog(),
                    );
                  },
                ),

                SizedBox(height: screen.height * 0.03),

                const AppointmentDetails(),

                SizedBox(height: screen.height * 0.03),
              ],
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screen.width * 0.05,
              vertical: screen.height * 0.015,
            ),
            child: MainButton(
              text: "الدفع الان",
              onTap: widget.onpres,
              height: screen.height * 0.065,
            ),
          ),
        ),
      ],
    );
  }
}
