import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_bottomsheet.dart';
import 'package:flutter/widgets.dart';
import 'package:svg_flutter/svg.dart';

class JaibDialogContent extends StatefulWidget {
  const JaibDialogContent({super.key});

  @override
  State<JaibDialogContent> createState() => _JaibDialogContentState();
}

class _JaibDialogContentState extends State<JaibDialogContent> {
  bool compeletePayment = false;
  void showBottomSheetNow() {
    setState(() {
      compeletePayment = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.gray200Color,
        border: Border.all(color: Color.fromARGB(255, 171, 25, 32), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),

      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/jaib.svg',
            width: 70,
            height: 70,
            colorFilter: ColorFilter.mode(Color(0xffdb232d), BlendMode.srcIn),
          ),
          SizedBox(height: 5),
          Text(
            'ادخل كود الشراء',
            style: FontStyles.headLine4.copyWith(color: Color(0xffdb232d)),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          MainInputField(
            hintText: '                   ********* ',
            leftIconPath: '',
            rightIconPath: '',
            isShowRightIcon: false,
            isShowLeftIcon: false,
            border: Color(0xffdb232d),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          MainButton(
            text: 'تاكيد',
            color: Color(0xffdb232d),
            onTap: () {
              PaymentBottomSheet();
              showBottomSheetNow();
              Future.delayed(Duration(milliseconds: 300), () {});
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
