import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/schedule_capacity_model.dart';

class CapacityInfoWidget extends StatelessWidget {
  final ScheduleCapacity capacity;
  final bool isReturningPatient;

  const CapacityInfoWidget({
    super.key,
    required this.capacity,
    required this.isReturningPatient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canBook = capacity.canAcceptPatient(isReturningPatient);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: canBook
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: canBook ? Colors.green : Colors.orange,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                canBook ? Icons.check_circle : Icons.schedule,
                color: canBook ? Colors.green : Colors.orange,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                canBook ? 'متاح للحجز' : 'قائمة الانتظار',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: canBook ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            'الوقت المتبقي:',
            capacity.formattedRemainingTime,
            Icons.timer,
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            'المواعيد المحجوزة:',
            '${capacity.bookedCount}',
            Icons.people,
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            'مدة الجلسة:',
            '${capacity.getPatientDuration(isReturningPatient)} دقيقة',
            Icons.access_time,
          ),
          if (!canBook) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'سيتم إضافتك لقائمة الانتظار وإشعارك عند توفر موعد',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
