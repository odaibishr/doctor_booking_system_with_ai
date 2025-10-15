import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({super.key, required this.onSubmit});

  final Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

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
                  'اترك تعليقك',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'كيف كان حجزك مع الدكتور',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'رجاء قم باضافة تقييمك وتعليقك',
                    style: TextStyle(color: AppColors.gray500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/star_filled.svg',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 16),
                SvgPicture.asset(
                  'assets/icons/star_filled.svg',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 16),
                SvgPicture.asset(
                  'assets/icons/star_filled.svg',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 16),
                SvgPicture.asset(
                  'assets/icons/star_filled.svg',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 16),
                SvgPicture.asset(
                  'assets/icons/star_filled.svg',
                  height: 30,
                  width: 30,
                ),
              ],
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
  }
}
