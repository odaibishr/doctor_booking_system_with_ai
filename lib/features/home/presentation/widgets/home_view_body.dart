import 'dart:developer';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/category_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/doctor_banner_slider.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/section_header.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/doctor_card_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/hopitals_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/home_view_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with TickerProviderStateMixin {
  late AnimationController _bannerController;
  late AnimationController _categoriesController;
  late AnimationController _doctorsController;
  late AnimationController _hospitalsController;

  late Animation<double> _bannerFade;
  late Animation<double> _bannerScale;
  late Animation<double> _categoriesFade;
  late Animation<Offset> _categoriesSlide;
  late Animation<double> _doctorsFade;
  late Animation<Offset> _doctorsSlide;
  late Animation<double> _hospitalsFade;
  late Animation<Offset> _hospitalsSlide;

  bool _animationsStarted = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();

    final currentState = context.read<DoctorCubit>().state;
    if (currentState is DoctorsLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startAnimations();
      });
    } else {
      context.read<DoctorCubit>().fetchDoctors();
    }
  }

  void _initAnimations() {
    _bannerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _categoriesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _doctorsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _hospitalsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _bannerFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bannerController, curve: Curves.easeOutCubic),
    );
    _bannerScale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _bannerController, curve: Curves.easeOutCubic),
    );

    _categoriesFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _categoriesController,
        curve: Curves.easeOutCubic,
      ),
    );
    _categoriesSlide =
        Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _categoriesController,
            curve: Curves.easeOutCubic,
          ),
        );

    _doctorsFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _doctorsController, curve: Curves.easeOutCubic),
    );
    _doctorsSlide =
        Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _doctorsController,
            curve: Curves.easeOutCubic,
          ),
        );

    _hospitalsFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hospitalsController, curve: Curves.easeOutCubic),
    );
    _hospitalsSlide =
        Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _hospitalsController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  void _startAnimations() {
    if (_animationsStarted) return;
    _animationsStarted = true;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _bannerController.forward();
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _categoriesController.forward();
    });
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _doctorsController.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _hospitalsController.forward();
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _categoriesController.dispose();
    _doctorsController.dispose();
    _hospitalsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.scaffoldBackgroundDark
        : AppColors.white;

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
              backgroundColor: backgroundColor,
              surfaceTintColor: backgroundColor,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocConsumer<DoctorCubit, DoctorState>(
                  listener: (context, state) {
                    if (state is DoctorsError) {
                      context.showErrorToast(state.message);
                    }
                    if (state is DoctorsLoaded) {
                      _startAnimations();
                    }
                  },
                  builder: (context, state) {
                    if (state is DoctorsLoading || state is DoctorInitial) {
                      return const HomeViewSkeleton();
                    }
                    if (state is DoctorsLoaded) {
                      final doctors = state.doctors;
                      log(
                        'Number of doctors in HomeViewBody: ${doctors.length}',
                      );

                      return Column(
                        children: [
                          FadeTransition(
                            opacity: _bannerFade,
                            child: ScaleTransition(
                              scale: _bannerScale,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  DoctorBannerSlider(
                                    featuredDoctor: doctors
                                        .where(
                                          (doctor) => (doctor.isFeatured == 1),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FadeTransition(
                            opacity: _categoriesFade,
                            child: SlideTransition(
                              position: _categoriesSlide,
                              child: Column(
                                children: [
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
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FadeTransition(
                            opacity: _doctorsFade,
                            child: SlideTransition(
                              position: _doctorsSlide,
                              child: Column(
                                children: [
                                  SectionHeader(
                                    title: 'افضل الأطباء',
                                    moreText: 'إظهار المزيد',
                                    onTap: () {
                                      GoRouter.of(
                                        context,
                                      ).push(AppRouter.topDoctorsViewRoute);
                                    },
                                  ),
                                  const SizedBox(height: 3),
                                  DoctorCardListView(
                                    topOfDoctors: doctors
                                        .where(
                                          (doctor) => doctor.isTopDoctor == 1,
                                        )
                                        .take(5)
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FadeTransition(
                            opacity: _hospitalsFade,
                            child: SlideTransition(
                              position: _hospitalsSlide,
                              child: Column(
                                children: [
                                  SectionHeader(
                                    title: 'المستشفيات',
                                    moreText: 'إظهار المزيد',
                                    onTap: () {
                                      GoRouter.of(
                                        context,
                                      ).push(AppRouter.allHospitalsViewRoute);
                                    },
                                  ),
                                  const SizedBox(height: 3),
                                  const HopitalsListView(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }
                    if (state is DoctorsError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 64),
                            const SizedBox(height: 16),
                            Text(state.message),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<DoctorCubit>().fetchDoctors(
                                  forceRefresh: true,
                                );
                              },
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      );
                    }
                    return const HomeViewSkeleton();
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
