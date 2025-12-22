import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/ai_chat_body.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiChatView extends StatelessWidget {
  const AiChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AiChatCubit>(),
      child: Scaffold(body: SafeArea(child: AiChatBody())),
    );
  }
}
