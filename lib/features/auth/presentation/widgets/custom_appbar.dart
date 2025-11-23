import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AppBar2 extends StatelessWidget {
  const AppBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: CustomAppBar(
        title: '',
        isBackButtonVisible: true,
        isUserImageVisible: false,
      ),
      pinned: true,
      automaticallyImplyLeading: false,
    );
  }
}
