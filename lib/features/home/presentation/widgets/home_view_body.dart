import 'dart:developer';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/category_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/doctor_banner_slider.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/section_header.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/doctor_card_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/hopitals_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const CustomHomeAppBar(
                name: 'مرحبًا عدي',
                userImage: 'assets/images/my-photo.jpg',
              ),
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocConsumer<DoctorCubit, DoctorState>(
                  listener: (context, state) {
                    if (state is DoctorsError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is DoctorsLoading) {
                      return const CustomLoader(loaderSize: kLoaderSize);
                    }
                    List<Doctor> doctors = [];
                    if (state is DoctorsLoaded) {
                      doctors.addAll(state.doctors.reversed);
                      log(
                        'Number of doctors in HomeViewBody: ${doctors[0].toString()}',
                      );

                      return Column(
                        children: [
                          const SizedBox(height: 16),
                          DoctorBannerSlider(
                            featuredDoctor: doctors
                                .where((doctor) => (doctor.isFeatured == 1))
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          SectionHeader(
                            title: 'التخصصات',
                            moreText: 'إظهار المزيد',
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).push(AppRouter.categoryViewRoute);
                            },
                          ),
                          const SizedBox(height: 3),
                          const CategoryListView(),
                          const SizedBox(height: 16),
                          SectionHeader(
                            title: 'افضل الأطباء',
                            moreText: 'إظهار المزيد',
                            onTap: () {},
                          ),
                          const SizedBox(height: 3),
                          DoctorCardListView(
                            topOfDoctors: doctors
                                .where((doctor) => doctor.isTopDoctor == 1)
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          SectionHeader(
                            title: 'المستشفيات',
                            moreText: 'إظهار المزيد',
                            onTap: () {},
                          ),
                          const SizedBox(height: 3),
                          const HopitalsListView(),
                          const SizedBox(height: 16),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
