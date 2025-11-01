import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signup/presention/widget/custom_appbar.dart';
import 'package:flutter/material.dart';

class AiChatBody extends StatelessWidget {
  const AiChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 20),
      child: Column(
        children: [
          CustomAppBar(
            title: 'الطبيب الذكي',
            isBackButtonVisible: true,
            isUserImageVisible: false,
          ),
          Expanded(child: Text('dff')),
          Container(child: TextField()),
        ],
      ),
    );
  }
}
