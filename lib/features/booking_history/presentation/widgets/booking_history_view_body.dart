import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/booking_cards_list_view.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/tap_bar.dart';
import 'package:flutter/material.dart';

class BookingHistoryViewBody extends StatefulWidget {
  const BookingHistoryViewBody({super.key});

  @override
  State<BookingHistoryViewBody> createState() => _BookingHistoryViewBodyState();
}

class _BookingHistoryViewBodyState extends State<BookingHistoryViewBody> {
  int _selectedTab = 0;

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        children: [
          CustomAppBar(
            userImage: 'assets/images/my-photo.jpg',
            title: 'حجوزاتي',
            isBackButtonVisible: false,
            isUserImageVisible: true,
          ),
          const SizedBox(height: 16),
          TapBar(
            tabItems: ['القادمة', 'المنتهية', 'الملغاة'],
            selectedTab: _selectedTab,
            onTabChanged: _onTabChanged,
          ),
          const SizedBox(height: 16),
          Expanded(child: BookingCardsListView(currentTabIndex: _selectedTab)),
        ],
      ),
    );
  }
}
