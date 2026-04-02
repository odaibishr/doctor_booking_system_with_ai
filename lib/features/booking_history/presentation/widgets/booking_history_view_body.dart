import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/animated_widgets.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/tap_bar.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/manager/booking_history_cubit/booking_history_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/appointment_card.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/booking_cards_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/booking_history_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingHistoryViewBody extends StatefulWidget {
  const BookingHistoryViewBody({super.key});

  @override
  State<BookingHistoryViewBody> createState() => _BookingHistoryViewBodyState();
}

class _BookingHistoryViewBodyState extends State<BookingHistoryViewBody> {
  int _selectedTab = 0;
  final PageController _pageController = PageController();

  void _onTabChanged(int index) {
    setState(() => _selectedTab = index);

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageSwiped(int index) {
    setState(() => _selectedTab = index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        children: [
          AnimatedEntrance(
            delay: const Duration(milliseconds: 100),
            animationType: AnimationType.fadeSlideDown,
            child: CustomAppBar(
              title: 'سجل الحجوزات',
              isBackButtonVisible: false,
              isUserImageVisible: true,
            ),
          ),
          const SizedBox(height: 16),
          AnimatedEntrance(
            delay: const Duration(milliseconds: 200),
            animationType: AnimationType.fadeSlideUp,
            child: TapBar(
              tabItems: const [
                'قائمة الانتظار',
                'القادمة',
                'المكتملة',
                'الملغاة',
              ],
              selectedTab: _selectedTab,
              onTabChanged: _onTabChanged,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocListener<BookingHistoryCubit, BookingHistoryState>(
              listenWhen: (previous, current) =>
                  current is CancelAppointmentSuccess ||
                  current is CancelAppointmentError ||
                  current is RescheduleAppointmentSuccess ||
                  current is RescheduleAppointmentError,
              listener: (context, state) {
                if (state is CancelAppointmentSuccess) {
                  context.showSuccessToast('تم إلغاء الموعد بنجاح');
                } else if (state is CancelAppointmentError) {
                  context.showErrorToast(state.message);
                } else if (state is RescheduleAppointmentSuccess) {
                  context.showSuccessToast('تم إعادة جدولة الموعد بنجاح');
                } else if (state is RescheduleAppointmentError) {
                  context.showErrorToast(state.message);
                }
              },
              child: BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
                builder: (context, state) {
                  if (state is BookingHistoryLoading &&
                      state.bookings.isEmpty) {
                    return const BookingHistorySkeleton();
                  }

                  if (state is BookingHistoryError && state.bookings.isEmpty) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: context.errorColor),
                      ),
                    );
                  }

                  if (state.bookings.isEmpty &&
                      state is! BookingHistoryLoading) {
                    return const Center(child: Text('لا توجد حجوزات حالياً'));
                  }

                  final groupedBookings = _groupBookingsByStatus(
                    state.bookings,
                  );

                  return AnimatedEntrance(
                    delay: const Duration(milliseconds: 300),
                    animationType: AnimationType.fade,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: _onPageSwiped,
                      children: [
                        BookingCardsListView(
                          bookings:
                              groupedBookings[AppointmentStatus.waiting] ??
                              const <Booking>[],
                          status: AppointmentStatus.waiting,
                        ),
                        BookingCardsListView(
                          bookings:
                              groupedBookings[AppointmentStatus.upcoming] ??
                              const <Booking>[],
                          status: AppointmentStatus.upcoming,
                        ),
                        BookingCardsListView(
                          bookings:
                              groupedBookings[AppointmentStatus.completed] ??
                              const <Booking>[],
                          status: AppointmentStatus.completed,
                        ),
                        BookingCardsListView(
                          bookings:
                              groupedBookings[AppointmentStatus.cancelled] ??
                              const <Booking>[],
                          status: AppointmentStatus.cancelled,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<AppointmentStatus, List<Booking>> _groupBookingsByStatus(
    List<Booking> bookings,
  ) {
    final grouped = {
      AppointmentStatus.waiting: <Booking>[],
      AppointmentStatus.upcoming: <Booking>[],
      AppointmentStatus.completed: <Booking>[],
      AppointmentStatus.cancelled: <Booking>[],
    };

    for (final booking in bookings) {
      final status = _mapBookingToStatus(booking);
      grouped[status]?.add(booking);
    }

    return grouped;
  }

  AppointmentStatus _mapBookingToStatus(Booking booking) {
    final normalizedStatus = booking.status.toLowerCase();

    if (normalizedStatus == 'cancelled' || normalizedStatus == 'canceled') {
      return AppointmentStatus.cancelled;
    }

    if (booking.isCompleted || normalizedStatus == 'completed') {
      return AppointmentStatus.completed;
    }

    if (normalizedStatus == 'pending' || normalizedStatus == 'waiting') {
      return AppointmentStatus.waiting;
    }

    return AppointmentStatus.upcoming;
  }
}
