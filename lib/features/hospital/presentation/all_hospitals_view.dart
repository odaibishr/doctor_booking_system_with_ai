import 'package:doctor_booking_system_with_ai/core/manager/hospital/hospital_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/hospital_card_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllHospitalsView extends StatefulWidget {
  const AllHospitalsView({super.key});

  @override
  State<AllHospitalsView> createState() => _AllHospitalsViewState();
}

class _AllHospitalsViewState extends State<AllHospitalsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const CustomAppBar(
                title: 'جميع المستشفيات',
                isBackButtonVisible: true,
                isUserImageVisible: false,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<HospitalCubit, HospitalState>(
                  builder: (context, state) {
                    if (state is HospitalLoading) {
                      return const Center(
                        child: CustomLoader(loaderSize: kLoaderSize),
                      );
                    } else if (state is HospitalError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: AppColors.getError(context),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.message,
                              style: FontStyles.body1.copyWith(
                                color: AppColors.getError(context),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<HospitalCubit>().getHospitals();
                              },
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      );
                    } else if (state is HospitalLoadded) {
                      final hospitals = state.hospitals;

                      if (hospitals.isEmpty) {
                        return Center(
                          child: Text(
                            'لا توجد مستشفيات متاحة حالياً',
                            style: FontStyles.body1.copyWith(
                              color: AppColors.getGray600(context),
                            ),
                          ),
                        );
                      }

                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: hospitals.length,
                          itemBuilder: (context, index) {
                            return TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: Duration(
                                milliseconds: 300 + (index * 50),
                              ),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: Opacity(opacity: value, child: child),
                                );
                              },
                              child: HospitalCardHorizontal(
                                hospital: hospitals[index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CustomLoader(loaderSize: kLoaderSize),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
