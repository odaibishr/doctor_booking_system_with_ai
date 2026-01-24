import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/categories/presentation/widget/category_graide.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SpecialtyCubit>().getAllSpecialties();
    });
  }

  @override
  Widget build(BuildContext context) {
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
