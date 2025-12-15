import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/back_button.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/toggle_favorite/toggle_favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsAppBar extends StatefulWidget {
  const DetailsAppBar({
    super.key,
    required this.title,
    required this.doctorId,
    this.initialIsFavorite = false,
  });
  final String title;
  final int? doctorId;
  final bool initialIsFavorite;

  @override
  State<DetailsAppBar> createState() => _DetailsAppBarState();
}

class _DetailsAppBarState extends State<DetailsAppBar> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialIsFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocConsumer<ToggleFavoriteCubit, ToggleFavoriteState>(
          listener: (BuildContext context, state) {
            if (state is ToggleFavoriteSuccess) {
              setState(() => isFavorite = state.isFavorite);
              context.showSuccessToast(
                state.isFavorite
                    ? 'تمت الإضافة إلى المفضلة'
                    : 'تمت الإزالة من المفضلة',
              );
            } else if (state is ToggleFavoriteError) {
              context.showErrorToast(
                state.message.isNotEmpty
                    ? state.message
                    : 'حدث خطأ ما، يرجى المحاولة مرة أخرى',
              );
            }
          },
          builder: (BuildContext context, state) {
            final isLoading = state is ToggleFavoriteLoading;
            return GestureDetector(
              onTap: isLoading || widget.doctorId == null
                  ? null
                  : () => context
                        .read<ToggleFavoriteCubit>()
                        .toggleFavoriteDoctor(
                          widget.doctorId!,
                          currentFavorite: isFavorite,
                        ),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary),
                ),
                child: ClipOval(
                  child: Center(
                    child: isLoading
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        : Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: isFavorite
                                ? AppColors.error
                                : AppColors.primary,
                          ),
                  ),
                ),
              ),
            );
          },
        ),
        Text(
          widget.title,
          style: FontStyles.headLine4.copyWith(fontWeight: FontWeight.bold),
        ),
        BackButtons(),
      ],
    );
  }
}
