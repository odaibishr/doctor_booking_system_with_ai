import 'package:doctor_booking_system_with_ai/core/manager/review/review_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog({super.key, required this.doctorId});

  final int doctorId;

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _setRating(int value) {
    setState(() => _rating = value);
  }

  Future<void> _submit(BuildContext context) async {
    final comment = _commentController.text.trim();

    if (_rating <= 0) {
      context.showErrorToast('يرجى اختيار التقييم');
      return;
    }
    if (comment.isEmpty) {
      context.showErrorToast('يرجى كتابة المراجعة');
      return;
    }
    if (widget.doctorId <= 0) {
      context.showErrorToast('تعذر إضافة المراجعة');
      return;
    }

    await context.read<ReviewCubit>().createReview(
      doctorId: widget.doctorId,
      rating: _rating,
      comment: comment,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<ReviewCubit>(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 20,
            left: 20,
            top: 16,
          ),
          child: BlocListener<ReviewCubit, ReviewState>(
            listener: (context, state) {
              if (state is ReviewFailure) {
                context.showErrorToast(state.message);
              }
              if (state is ReviewSuccess) {
                Navigator.of(context).pop();
                context.showSuccessToast('تم إرسال المراجعة بنجاح');
              }
            },
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
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'إضافة مراجعة',
                      style: FontStyles.subTitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(color: context.gray300Color),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'كيف كانت تجربتك؟',
                        style: FontStyles.subTitle2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'اضغط على النجوم لتحديد التقييم',
                        style: FontStyles.body2.copyWith(
                          color: context.gray500Color,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _StarRating(rating: _rating, onChanged: _setRating),
                const SizedBox(height: 16),
                TextField(
                  controller: _commentController,
                  maxLines: 3,
                  cursorColor: context.gray500Color,
                  decoration: InputDecoration(
                    hintText: 'اكتب مراجعتك هنا...',
                    hintTextDirection: TextDirection.rtl,
                    filled: true,
                    fillColor: context.gray100Color,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: context.gray200Color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: context.gray200Color),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: context.primaryColor),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<ReviewCubit, ReviewState>(
                  builder: (context, state) {
                    final isSubmitting = state is ReviewSubmitting;
                    return MainButton(
                      text: isSubmitting ? 'جاري الإرسال...' : 'إرسال',
                      onTap: isSubmitting ? () {} : () => _submit(context),
                      color: isSubmitting
                          ? context.gray300Color
                          : context.primaryColor,
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating({required this.rating, required this.onChanged});

  final int rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final value = i + 1;
        final isFilled = value <= rating;
        final asset = isFilled
            ? 'assets/icons/star_filled.svg'
            : 'assets/icons/star.svg';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onChanged(value),
            child: SvgPicture.asset(
              asset,
              height: 30,
              width: 30,
              colorFilter: ColorFilter.mode(
                isFilled ? context.yellowColor : context.gray300Color,
                BlendMode.srcIn,
              ),
            ),
          ),
        );
      }),
    );
  }
}
