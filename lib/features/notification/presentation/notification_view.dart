import 'package:doctor_booking_system_with_ai/features/notification/presentation/widgets/notification_view_body.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: NotificationViewBody()));
  }
}
