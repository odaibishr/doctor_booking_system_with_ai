import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presention/widget/date_textfield.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presention/widget/gender_textfield.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presention/widget/profile_image.dart';
import 'package:flutter/material.dart';

class CreateProfileBody extends StatefulWidget {
  const CreateProfileBody({super.key});

  @override
  _CreateProfileBodyState createState() => _CreateProfileBodyState();
}

class _CreateProfileBodyState extends State<CreateProfileBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: CustomAppBar(
            title: '',
            isBackButtonVisible: true,
            isUserImageVisible: false,
          ),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  'تكملة المعلومات الشخصية',
                  style: FontStyles.headLine4.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                SubTitle(
                  text: 'لاتقلق انت الوحيد الذي يمكنة رؤية معلوماتك الشخصية',
                ),
                SizedBox(height: 35),
                ProfileImage(),//Profile image
                MainInputField(
                  //User Name textfield
                  hintText: 'اسم المستخدم ',
                  leftIconPath: 'assets/icons/user.svg',
                  rightIconPath: 'assets/icons/user.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: false,
                ),
                SizedBox(height: 15),
                MainInputField(
                  hintText: 'رقم المستخدم',
                  leftIconPath: 'assets/icons/country.svg',
                  rightIconPath: 'assets/icons/country.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: false,
                  is_number: true,
                ),
                SizedBox(height: 15),
                DateTextField(//date textfield
                  onchanged: (DateTime? date) {
                    
                    //TODO here the date returnd value
                  },
                ),
                SizedBox(height: 15),
                GenderTextField(//Gender textfield
                  onchanged: (value) {
                    //Gender textfield
                    //TODO here the Gender return value
                  },
                ),
                SizedBox(height: 25),
                MainButton(text: 'تكملة  المعلومات', onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم اكمال معلوماتك بنجاح')));
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
