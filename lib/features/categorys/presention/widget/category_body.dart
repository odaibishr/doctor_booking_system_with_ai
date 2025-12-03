import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/categorys/presention/widget/category_graide.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {'title': 'طب الأطفال', 'icon': 'assets/icons/child.svg'},
      {'title': 'الطب الباطني', 'icon': 'assets/icons/brain.svg'}, //This is
      {'title': 'مخ واعصاب', 'icon': 'assets/icons/brain.svg'},
      {'title': 'أمراض الصدر', 'icon': 'assets/icons/kidney.svg'}, //This is
      {'title': 'أمراض الكلى', 'icon': 'assets/icons/kidney.svg'}, //This is
      {'title': 'أمراض القلب', 'icon': 'assets/icons/heart.svg'},
      {'title': 'الأورام', 'icon': 'assets/icons/neurology.svg'},
      {'title': 'أمراض الأعصاب', 'icon': 'assets/icons/neurology.svg'},
      {'title': 'أمراض الدم', 'icon': 'assets/icons/blood.svg'},
      {
        'title': 'جراحة الأنف والأذن والحنجرة',
        'icon': 'assets/icons/ذ.svg',
      },
      {'title': 'جراحة التجميل', 'icon': 'assets/icons/FemaleSurgeon.svg'},
      {'title': 'جراحة العظام', 'icon': 'assets/icons/orthopedicclinic.svg'},
      {'title': 'المختبرات الطبية', 'icon': 'assets/icons/Group.svg'},
      {'title': 'الطب النفسي', 'icon': 'assets/icons/Therapy.svg'},
      {'title': 'جراحة العيون', 'icon': 'assets/icons/Eye.svg'},
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: CustomAppBar(
              title: 'التخصصات',
              isBackButtonVisible: true,
              isUserImageVisible: false,
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<SpecialtyCubit, SpecialtyState>(
              builder: (context, state) {
                if (state is SpecialtyLoaded) {
                  return CategoryGride(specialties: state.specialties);
                } else if (state is SpecialtyError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: FontStyles.body3.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  );
                } else {
                  return const CustomLoader(loaderSize: kLoaderSize);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
