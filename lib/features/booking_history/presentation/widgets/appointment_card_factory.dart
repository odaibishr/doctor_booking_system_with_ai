import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:go_router/go_router.dart';
import '../widgets/appointment_card.dart'; // المسار بحسب موقع البطاقة

class AppointmentCardFactory {
  static List<Widget> getButtons({
    required BuildContext context,
    required AppointmentStatus status,
    required String textButton1,
    required String textButton2,
  }) {
    switch (status) {
      case AppointmentStatus.upcoming:
        return [
          Expanded(
            child: MainButton(
              text: textButton1,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم فتح شاشة إعادة الجدولة')),
                );
              },
              height: 28,
              radius: 6,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MainButton(
              text: textButton2,
              onTap: () => _showCancelBottomSheet(context),
              height: 28,
              radius: 6,
              color: AppColors.gray300,
            ),
          ),
        ];

      case AppointmentStatus.completed:
        return [
          Expanded(
            child: MainButton(
              text: textButton1,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم فتح تفاصيل الموعد')),
                );
              },
              height: 28,
              radius: 6,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MainButton(
              text: textButton2,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم فتح شاشة التقييم')),
                );
              },
              height: 28,
              radius: 6,
              color: AppColors.gray300,
            ),
          ),
        ];

      case AppointmentStatus.cancelled:
        return [
          Expanded(
            child: MainButton(
              text: textButton1,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم عرض سبب الإلغاء')),
                );
              },
              height: 28,
              radius: 6,
              color: AppColors.gray300,
            ),
          ),
        ];
    }
  }

  static void _showCancelBottomSheet(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              right: 20,
              left: 20,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'إلغاء الحجز',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(color: AppColors.gray300),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'هل انت متأكد من ذلك',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'رجاء قم بإضافة سبب لذلك',
                        style: TextStyle(color: AppColors.gray500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: reasonController,
                  maxLines: 3,
                  cursorColor: AppColors.gray500,
                  decoration: InputDecoration(
                    hintText: 'اكتب السبب ...',
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.gray200),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3A8C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      final reason = reasonController.text.trim();
                      if (reason.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('يرجى كتابة السبب قبل الإرسال'),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم إرسال السبب: $reason')),
                        );
                      }
                    },
                    child: const Text(
                      'إرسال',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
