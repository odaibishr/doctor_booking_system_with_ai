import 'dart:async';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/entities/waitlist_entry.dart';

class WaitlistCard extends StatefulWidget {
  final WaitlistEntry entry;
  final VoidCallback onLeave;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const WaitlistCard({
    super.key,
    required this.entry,
    required this.onLeave,
    this.onAccept,
    this.onDecline,
  });

  @override
  State<WaitlistCard> createState() => _WaitlistCardState();
}

class _WaitlistCardState extends State<WaitlistCard> {
  Timer? _countdownTimer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.entry.isNotified && widget.entry.expiresAt != null) {
      _startCountdown();
    }
  }

  void _startCountdown() {
    _updateRemainingTime();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    if (widget.entry.expiresAt == null) return;

    final remaining = widget.entry.expiresAt!.difference(DateTime.now());
    setState(() {
      _remainingTime = remaining.isNegative ? Duration.zero : remaining;
    });

    if (remaining.isNegative) {
      _countdownTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNotified = widget.entry.isNotified;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isNotified ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isNotified
            ? const BorderSide(color: AppColors.success, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isNotified) _buildNotifiedBanner(),
            _buildDoctorInfo(theme),
            const SizedBox(height: 12),
            _buildStatusRow(theme),
            if (widget.entry.preferredDate != null) ...[
              const SizedBox(height: 8),
              _buildPreferredDate(theme),
            ],
            const SizedBox(height: 16),
            _buildActions(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifiedBanner() {
    final minutes = _remainingTime.inMinutes;
    final seconds = _remainingTime.inSeconds % 60;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.success, Color(0xFF2E7D32)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.celebration, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'موعد متاح الآن!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'الوقت المتبقي: $minutes:${seconds.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo(ThemeData theme) {
    final doctor = widget.entry.doctor;

    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.gray200,
          backgroundImage: doctor?.profileImage.isNotEmpty == true
              ? NetworkImage(doctor!.profileImage)
              : null,
          child: doctor?.profileImage.isEmpty != false
              ? const Icon(Icons.person, size: 28, color: AppColors.gray400)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor?.name ?? 'طبيب',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (doctor != null)
                Text(
                  doctor.specialty.name,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.gray500,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(ThemeData theme) {
    return Row(
      children: [
        _buildInfoChip(
          icon: Icons.tag,
          label: 'الترتيب: ${widget.entry.position}',
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        _buildInfoChip(
          icon: _getStatusIcon(),
          label: _getStatusLabel(),
          color: _getStatusColor(),
        ),
      ],
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferredDate(ThemeData theme) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 16, color: AppColors.gray500),
        const SizedBox(width: 8),
        Text(
          'التاريخ المفضل: ${widget.entry.preferredDate}',
          style: theme.textTheme.bodySmall?.copyWith(color: AppColors.gray600),
        ),
      ],
    );
  }

  Widget _buildActions(ThemeData theme) {
    final isNotified = widget.entry.isNotified;

    if (isNotified) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: widget.onDecline,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
              ),
              child: const Text('رفض'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: widget.onAccept,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
              ),
              child: const Text('احجز الآن'),
            ),
          ),
        ],
      );
    }

    return OutlinedButton.icon(
      onPressed: widget.onLeave,
      icon: const Icon(Icons.exit_to_app),
      label: const Text('مغادرة القائمة'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.error,
        side: const BorderSide(color: AppColors.error),
      ),
    );
  }

  IconData _getStatusIcon() {
    switch (widget.entry.status) {
      case 'waiting':
        return Icons.hourglass_empty;
      case 'notified':
        return Icons.notifications_active;
      case 'booked':
        return Icons.check_circle;
      case 'expired':
        return Icons.timer_off;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _getStatusLabel() {
    switch (widget.entry.status) {
      case 'waiting':
        return 'في الانتظار';
      case 'notified':
        return 'موعد متاح';
      case 'booked':
        return 'تم الحجز';
      case 'expired':
        return 'انتهت الصلاحية';
      case 'cancelled':
        return 'ملغي';
      default:
        return widget.entry.status;
    }
  }

  Color _getStatusColor() {
    switch (widget.entry.status) {
      case 'waiting':
        return AppColors.yellow;
      case 'notified':
        return AppColors.success;
      case 'booked':
        return AppColors.primary;
      case 'expired':
        return AppColors.error;
      case 'cancelled':
        return AppColors.gray500;
      default:
        return AppColors.gray500;
    }
  }
}
