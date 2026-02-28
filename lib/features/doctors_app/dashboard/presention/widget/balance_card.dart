import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/chart_column.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/earnings_data.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final EarningsData? earnings;

  const BalanceCard({super.key, this.earnings});

  @override
  Widget build(BuildContext context) {
    final balance = earnings?.filtered ?? 0.0;
    final todayEarnings = earnings?.today ?? 0.0;
    final weekEarnings = earnings?.week ?? 0.0;
    final monthEarnings = earnings?.month ?? 0.0;

    final maxVal = [
      todayEarnings,
      weekEarnings,
      monthEarnings,
      balance,
    ].reduce((a, b) => a > b ? a : b);
    final scale = maxVal > 0 ? 70.0 / maxVal : 1.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "الرصيد الحالي",
                    style: FontStyles.body1.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        balance.toStringAsFixed(0),
                        style: FontStyles.headLine1.copyWith(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "ريال",
                        style: FontStyles.body1.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white,
                size: 32,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChartColumn(coulmnHeight: (todayEarnings * scale).clamp(10, 70)),
              ChartColumn(coulmnHeight: (weekEarnings * scale).clamp(10, 70)),
              ChartColumn(coulmnHeight: (monthEarnings * scale).clamp(10, 70)),
              ChartColumn(coulmnHeight: (balance * scale).clamp(10, 70)),
              ChartColumn(coulmnHeight: 40),
              ChartColumn(coulmnHeight: 55),
              ChartColumn(coulmnHeight: 35),
              ChartColumn(coulmnHeight: 45),
            ],
          ),
        ],
      ),
    );
  }
}
