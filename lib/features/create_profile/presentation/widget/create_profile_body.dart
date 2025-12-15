import 'dart:io';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:doctor_booking_system_with_ai/core/manager/profile/profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presentation/widget/date_textfield.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presentation/widget/gender_textfield.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presentation/widget/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateProfileBody extends StatefulWidget {
  const CreateProfileBody({super.key});

  @override
  State<CreateProfileBody> createState() => _CreateProfileBodyState();
}

class _CreateProfileBodyState extends State<CreateProfileBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  String? selectedGender;
  File? selectedImage;

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
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
                if (state is ProfileSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم انشاء الملف الشخصي بنجاح'),
                    ),
                  );
                  GoRouter.of(
                    context,
                  ).pushReplacement(AppRouter.appNavigationRoute);
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const CustomLoader(loaderSize: kLoaderSize);
                }
                return Form(
                  key: _formKey,
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
                        text:
                            'لاتقلق انت الوحيد الذي يمكنة رؤية معلوماتك الشخصية',
                      ),
                      SizedBox(height: 35),
                      ProfileImage(
                        onImageSelected: (image) => selectedImage = image,
                      ), //Profile image
                      SizedBox(height: 15),
                      MainInputField(
                        hintText: 'رقم المستخدم',
                        leftIconPath: 'assets/icons/country.svg',
                        rightIconPath: 'assets/icons/country.svg',
                        isShowRightIcon: true,
                        isShowLeftIcon: false,
                        isNumber: true,
                        controller: phoneController,
                      ),
                      SizedBox(height: 15),
                      DateTextField(
                        //date textfield
                        onchanged: (DateTime? date) {
                          birthDateController.text = date.toString();
                        },
                      ),
                      SizedBox(height: 15),
                      GenderTextField(
                        //Gender textfield
                        onchanged: (value) {
                          //Gender textfield
                          if (value == 'ذكر') {
                            selectedGender = 'male';
                          } else {
                            selectedGender = 'female';
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      MainButton(
                        text: 'حفظ المعلومات',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            //call create profile cubit function
                            BlocProvider.of<ProfileCubit>(
                              context,
                            ).createProfile(
                              phone: phoneController.text,
                              birthDate: birthDateController.text,
                              gender: selectedGender!,
                              locationId: 1,
                              imageFile: selectedImage,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
