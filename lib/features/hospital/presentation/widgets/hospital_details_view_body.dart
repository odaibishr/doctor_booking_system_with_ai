import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/tap_bar.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/manager/hospital_detailes/hospital_detailes_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_header_section.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'hospital_details_about_tab.dart';
import 'hospital_details_doctors_tab.dart';
import 'hospital_details_reviews_tab.dart';

class HospitalDetailsViewBody extends StatefulWidget {
  const HospitalDetailsViewBody({super.key, required this.hospitalId});
  final int hospitalId;

  @override
  State<HospitalDetailsViewBody> createState() =>
      _HospitalDetailsViewBodyState();
}

class _HospitalDetailsViewBodyState extends State<HospitalDetailsViewBody> {
  int _selectedTab = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<HospitalDetailesCubit>().getHospitalDetailes(
      widget.hospitalId,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalDetailesCubit, HospitalDetailesState>(
      builder: (context, state) {
        if (state is HospitalDetailesLoading ||
            state is HospitalDetailesInitial) {
          return const Scaffold(body: CustomLoader(loaderSize: kLoaderSize));
        }

        if (state is HospitalDetailesError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('خطأ فى الاتصال', style: FontStyles.headLine3),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context
                          .read<HospitalDetailesCubit>()
                          .getHospitalDetailes(widget.hospitalId),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is HospitalDetailesLoaded) {
          final hospital = state.hospital;

          return Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  toolbarHeight: 72,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  title: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: CustomAppBar(
                      title: 'معلومات المستشفى',
                      isBackButtonVisible: true,
                      isUserImageVisible: false,
                      isHeartIconVisible: false,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HospitalHeaderSection(
                          hospitalName: hospital.name,
                          hospitalLocation: hospital.address,
                          hospitalImage: hospital.image,
                        ),
                        const SizedBox(height: 20),
                        const HospitalStatsSection(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        TapBar(
                          tabItems: const ['عنا', 'المتخصصون', 'التقييمات'],
                          selectedTab: _selectedTab,
                          onTabChanged: (index) {
                            setState(() => _selectedTab = index);
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() => _selectedTab = index);
                            },
                            children: [
                              HospitalDetailsAboutTab(
                                doctors: hospital.doctors!,
                                reviews: _reviews,
                              ),
                              HospitalDetailsDoctorsTab(
                                doctors: hospital.doctors!,
                              ),
                              // HospitalDetailsReviewsTab(reviews: _reviews),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  final List<Map<String, dynamic>> _reviews = [
    {
      'id': '1',
      'name': 'Brooklyn Simmons',
      'rating': '4.5',
      'review':
          'Great care from the staff. The facility was clean and the doctors took time to explain everything.',
    },
    {
      'id': '2',
      'name': 'Eleanor Pena',
      'rating': '4.8',
      'review':
          'Quick check-in and very professional team. I felt heard and respected throughout my visit.',
    },
    {
      'id': '3',
      'name': 'Courtney Henry',
      'rating': '4.2',
      'review':
          'Good experience overall. There was a slight wait, but the service quality made up for it.',
    },
  ];
}
