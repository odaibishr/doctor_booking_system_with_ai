import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/category_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/doctor_banner_slider.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/section_header.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/doctor_card_list_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const CustomHomeAppBar(
                      name: 'مرحبًا عدي',
                      userImage: 'assets/images/my-photo.jpg',
                    ),
                    const SizedBox(height: 16),
                    const DoctorBannerSlider(),
                    const SizedBox(height: 16),
                    SectionHeader(
                      title: 'التخصصات',
                      moreText: 'إظهار المزيد',
                      onTap: () {},
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
                    const DoctorCardListView(),
                    const SizedBox(height: 16),
                    SectionHeader(
                      title: 'أقرب المراكز',
                      moreText: 'إظهار المزيد',
                      onTap: () {},
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
