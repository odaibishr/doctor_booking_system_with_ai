import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/network/network_cubit.dart';

class OfflineDialog extends StatelessWidget {
  const OfflineDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Icon(Icons.wifi_off, size: 64, color: Colors.redAccent),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'لا يوجد اتصال بالإنترنت',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              'أنت الآن في وضع عدم الاتصال. يمكنك المتابعة بتجربة التطبيق باستخدام البيانات المخزنة محلياً.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: context.gray300Color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              context.read<NetworkCubit>().acknowledgeOffline();
            },
            child: Text(
              'استخدام البيانات المحلية',
              style: TextStyle(color: context.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
