import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/presentation/cubit/waitlist_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/presentation/cubit/waitlist_state.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/presentation/widgets/waitlist_card.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/presentation/widgets/empty_waitlist_view.dart';

class MyWaitlistsPage extends StatefulWidget {
  const MyWaitlistsPage({super.key});

  @override
  State<MyWaitlistsPage> createState() => _MyWaitlistsPageState();
}

class _MyWaitlistsPageState extends State<MyWaitlistsPage> {
  @override
  void initState() {
    super.initState();
    context.read<WaitlistCubit>().loadMyWaitlists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              CustomAppBar(
                title: 'قائمة الانتظار',
                isBackButtonVisible: true,
                isUserImageVisible: false,
              ),
              Expanded(
                child: BlocConsumer<WaitlistCubit, WaitlistState>(
                  listener: (context, state) {
                    if (state is WaitlistError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    } else if (state is WaitlistLeft) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم إزالتك من قائمة الانتظار'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                      context.read<WaitlistCubit>().loadMyWaitlists();
                    }
                  },
                  builder: (context, state) {
                    if (state is WaitlistLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is WaitlistLoaded) {
                      if (state.waitlists.isEmpty) {
                        return const EmptyWaitlistView();
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<WaitlistCubit>().loadMyWaitlists();
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.waitlists.length,
                          itemBuilder: (context, index) {
                            final entry = state.waitlists[index];
                            return WaitlistCard(
                              entry: entry,
                              onLeave: () {
                                _showLeaveConfirmation(context, entry.id);
                              },
                              onAccept: entry.isNotified
                                  ? () {
                                      _showAcceptDialog(context, entry);
                                    }
                                  : null,
                              onDecline: entry.isNotified
                                  ? () {
                                      _showDeclineConfirmation(
                                        context,
                                        entry.id,
                                      );
                                    }
                                  : null,
                            );
                          },
                        ),
                      );
                    }

                    return const Center(child: EmptyWaitlistView());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLeaveConfirmation(BuildContext context, int waitlistId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تأكيد المغادرة'),
        content: const Text('هل أنت متأكد من مغادرة قائمة الانتظار؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<WaitlistCubit>().leaveWaitlist(waitlistId);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('مغادرة'),
          ),
        ],
      ),
    );
  }

  void _showAcceptDialog(BuildContext context, dynamic entry) {
    // TODO: Implement accept slot dialog with schedule selection
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('🎉 موعد متاح!'),
        content: const Text('لديك موعد متاح الآن. هل تريد الحجز؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('لاحقاً'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Navigate to booking page with pre-filled data
            },
            child: const Text('احجز الآن'),
          ),
        ],
      ),
    );
  }

  void _showDeclineConfirmation(BuildContext context, int waitlistId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('رفض الموعد'),
        content: const Text(
          'هل أنت متأكد من رفض الموعد؟ سيتم إبلاغ الشخص التالي في القائمة.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<WaitlistCubit>().declineSlot(waitlistId);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('رفض'),
          ),
        ],
      ),
    );
  }
}
