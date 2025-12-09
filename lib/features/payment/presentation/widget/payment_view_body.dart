import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/JaibShowDialog.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/appointment_details.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/doctor_info.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_method_item.dart';
import 'package:flutter/material.dart';


class PaymentViewBody extends StatefulWidget {
  final bool? complete_payment;
  final VoidCallback onpres;
  const PaymentViewBody({
    super.key,
    this.complete_payment,
    required this.onpres,
  });

  @override
  State<PaymentViewBody> createState() => _PaymentViewBodyState();
}

class _PaymentViewBodyState extends State<PaymentViewBody> {
  // local mutable copy of the completion flag
  late bool completePayment;

  int selectedMethodIndex = 0;

  @override
  void initState() {
    super.initState();
    // initialize from the widget's (possibly nullable) value
    completePayment = widget.complete_payment ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'الدفع',
          isBackButtonVisible: true,
          isUserImageVisible: false,
        ),
        const SizedBox(height: 10),
        Column(
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
              style: FontStyles.subTitle3.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            PaymentMethodItem(
              label: '',
              iconPath: 'assets/images/jaib.svg',
              onTap: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return JaibShowDialog();
                    },
                  );
                });
              },
            ),
            const SizedBox(height: 16),
            // MainInputField(
            //   hintText: 'رقم البطاقة',
            //   leftIconPath: 'assets/icons/pay-card.svg',
            //   rightIconPath: 'assets/icons/edit-2.svg',
            //   isShowRightIcon: true,
            //   isShowLeftIcon: true,
            //   readonly: true,
            //   icon_onTap: () {
            //     GoRouter.of(context).push(AppRouter.addcardViewRoute);
            //   },
            // ),
            const SizedBox(height: 28),
            const AppointmentDetails(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MainButton(text: 'الدفع الان', onTap: widget.onpres),
            ),
          ],
        ),
      ],
    );
  }
}


