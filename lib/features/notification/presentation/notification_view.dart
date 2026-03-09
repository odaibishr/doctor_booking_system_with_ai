import 'package:doctor_booking_system_with_ai/features/notification/presentation/manager/notification_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/notification/presentation/widgets/notification_view_body.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<NotificationCubit>(),
      child: const Scaffold(body: SafeArea(child: NotificationViewBody())),
    );
  }
}
