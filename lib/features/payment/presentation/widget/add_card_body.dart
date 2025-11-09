import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/cvc_textfield.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/expirydate_textfield.dart';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:flutter/material.dart';

class AddCardBody extends StatelessWidget {
  const AddCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: 'إضافة بطاقة     ',
              isBackButtonVisible: true,
              isUserImageVisible: false,
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.06),
            Text(
              'اسم حامل البطاقة',
              style: FontStyles.subTitle3.copyWith(fontWeight: FontWeight.bold),
            ),
            MainInputField(
              hintText: '',
              leftIconPath: '',
              rightIconPath: '',
              isShowRightIcon: false,
              isShowLeftIcon: false,
            ),
            SizedBox(height: 20,),
             Text(
              'رقم البطاقة',
              style: FontStyles.subTitle3.copyWith(fontWeight: FontWeight.bold),
            ),
            MainInputField(
              hintText: '2512  ****  ****  ****',
              leftIconPath: '',
              rightIconPath: '',
              isShowRightIcon: false,
              isShowLeftIcon: false,
            ),
            SizedBox(height: 20,),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('تاريخ الإنتهاء',style: FontStyles.subTitle3.copyWith(fontWeight: FontWeight.bold),),
                  Container(width: 150,
                    child: ExpiryDateField(onChanged:(String month, String year){
                      //TODO
                    }))
                ],
              ),
              SizedBox(width: 40,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('رمز الامان',style: FontStyles.subTitle3.copyWith(fontWeight: FontWeight.bold),),
                  Container(width: 145,
                    child: CvvField(onChanged:(val){
                      //TODO
                    },))
                ],
              ),
              
            ],),
             SizedBox(height: 10),
            Row(children: [
              Icon(Icons.check_box_rounded,color:AppColors.primary),
              SizedBox(width: 5,),
              Text('حفظ البطاقة',style: FontStyles.subTitle3.copyWith(fontWeight: FontWeight.bold),),
              
            ],),
            SizedBox(height: 12,),
            Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: MainButton(text: 'إضافة بطاقة', onTap: () {
            
          }),
        ),
          ],
        ),
      ),
    );
  }
}
