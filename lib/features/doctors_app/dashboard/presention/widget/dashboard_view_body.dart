import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/balance_card.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/choice_item.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/doctor_card.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/reviews/presention/doctor_reviews_view.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/dashboard/doctor_dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key});

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  int _selectedChoice = 0;
  final List<String> _choices = ['الكل', 'يومي', 'اسبوعي', 'شهري'];
  final List<String> _filters = ['all', 'today', 'week', 'month'];

  void _onChoiceSelected(int index) {
    setState(() => _selectedChoice = index);
    context.read<DoctorDashboardCubit>().fetchDashboard(
      filter: _filters[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDashboardCubit, DoctorDashboardState>(
      builder: (context, state) {
        if (state is DoctorDashboardLoading) {
          return const Center(child: CustomLoader(loaderSize: kLoaderSize));
        }

        if (state is DoctorDashboardError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      context.read<DoctorDashboardCubit>().fetchDashboard(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (state is DoctorDashboardLoaded) {
          final stats = state.stats;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    BalanceCard(earnings: stats.earnings),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: List.generate(
                          _choices.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: ChoiceItem(
                              title: _choices[index],
                              isSelected: _selectedChoice == index,
                              onTap: () => _onChoiceSelected(index),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              DoctorCard(
                                cardIcon: Icons.people_alt_outlined,
                                cardTitle: 'عدد المرضى',
                                cardContent: '${stats.totalPatients}',
                              ),
                              DoctorCard(
                                cardIcon: Icons.history_rounded,
                                cardTitle: 'مراجعات',
                                cardContent: '${stats.reviewsCount}',
                                iconColor: Colors.orange,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DoctorReviewsView(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              DoctorCard(
                                cardIcon: Icons.check_circle_outline,
                                cardTitle: 'مواعيد مكتملة',
                                cardContent: '${stats.completedAppointments}',
                                iconColor: Colors.teal,
                              ),
                              DoctorCard(
                                cardIcon: Icons.cancel_outlined,
                                cardTitle: 'حجوزات ملغية',
                                cardContent: '${stats.cancelledAppointments}',
                                iconColor: Colors.red,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              DoctorCard(
                                cardIcon: Icons.calendar_today_rounded,
                                cardTitle: 'مواعيد اليوم',
                                cardContent: '${stats.todayAppointments}',
                                iconColor: Colors.green,
                              ),
                              DoctorCard(
                                cardIcon: Icons.upcoming_rounded,
                                cardTitle: 'المواعيد القادمة',
                                cardContent: '${stats.upcomingAppointments}',
                                iconColor: Colors.purple,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
