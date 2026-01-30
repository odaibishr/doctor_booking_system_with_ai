import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitConfirmationWrapper extends StatelessWidget {
  const ExitConfirmationWrapper({super.key, required this.child});

  final Widget child;

  Future<void> _showExitDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تأكيد الخروج', textAlign: TextAlign.center),
        content: const Text(
          'هل تريد الخروج من التطبيق؟',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('لا', style: TextStyle(color: context.gray500Color)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
              foregroundColor: context.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('نعم، خروج'),
          ),
        ],
      ),
    );

    if (result == true) {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _showExitDialog(context);
        }
      },
      child: child,
    );
  }
}
