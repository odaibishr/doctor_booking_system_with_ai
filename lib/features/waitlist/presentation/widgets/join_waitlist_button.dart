import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/presentation/cubit/waitlist_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/presentation/cubit/waitlist_state.dart';

class JoinWaitlistButton extends StatelessWidget {
  final int doctorId;
  final String doctorName;
  final String? preferredDate;
  final int? preferredScheduleId;
  final VoidCallback? onJoined;

  const JoinWaitlistButton({
    super.key,
    required this.doctorId,
    required this.doctorName,
    this.preferredDate,
    this.preferredScheduleId,
    this.onJoined,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WaitlistCubit, WaitlistState>(
      listener: (context, state) {
        if (state is WaitlistJoined) {
          _showSuccessDialog(context, state.position);
          onJoined?.call();
        } else if (state is WaitlistError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is WaitlistJoining;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: isLoading ? null : () => _showJoinConfirmation(context),
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.add_alert),
            label: Text(isLoading ? 'جاري الإضافة...' : 'انضم لقائمة الانتظار'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showJoinConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('الانضمام لقائمة الانتظار'),
        content: Text(
          'سيتم إضافتك لقائمة انتظار الدكتور $doctorName. سنبلغك فوراً عند توفر موعد.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<WaitlistCubit>().joinWaitlist(
                doctorId: doctorId,
                preferredDate: preferredDate,
                preferredScheduleId: preferredScheduleId,
              );
            },
            child: const Text('انضم الآن'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, int position) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: AppColors.success,
          size: 64,
        ),
        title: const Text('تمت الإضافة بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'أنت الآن في قائمة انتظار الدكتور $doctorName',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ترتيبك: $position',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'سنبلغك فوراً عند توفر موعد',
              style: TextStyle(color: AppColors.gray500),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
