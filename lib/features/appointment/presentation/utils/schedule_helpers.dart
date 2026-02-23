import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';

int toDayNumber(int weekday) {
  const map = {
    DateTime.saturday: 1,
    DateTime.sunday: 2,
    DateTime.monday: 3,
    DateTime.tuesday: 4,
    DateTime.wednesday: 5,
    DateTime.thursday: 6,
    DateTime.friday: 7,
  };
  return map[weekday] ?? 1;
}

DoctorSchedule? getCurrentSchedule(
  List<DoctorSchedule>? schedules,
  DateTime selectedDate,
) {
  if (schedules == null || schedules.isEmpty) return null;

  final targetDayNumber = toDayNumber(selectedDate.weekday);
  return schedules.firstWhere(
    (s) => (s.day?.dayNumber ?? s.dayId) == targetDayNumber,
    orElse: () => schedules.first,
  );
}

List<String> timeSlotsForPeriod(
  List<DoctorSchedule>? schedules,
  DateTime selectedDate,
  String? periodKey,
) {
  if (schedules == null || schedules.isEmpty) return [];

  final targetDayNumber = toDayNumber(selectedDate.weekday);
  final schedule = schedules.firstWhere(
    (s) => (s.day?.dayNumber ?? s.dayId) == targetDayNumber,
    orElse: () => schedules.first,
  );

  final start = int.parse(schedule.startTime.split(':')[0]);
  final end = int.parse(schedule.endTime.split(':')[0]);

  final List<String> slots = [];
  for (int h = start; h < end; h++) {
    final hourStr = h > 12 ? (h - 12).toString() : h.toString();
    final suffix = h >= 12 ? 'م' : 'ص';
    slots.add('$hourStr:00 $suffix');
    slots.add('$hourStr:30 $suffix');
  }

  if (periodKey == 'morning') {
    return slots.where((s) => s.contains('ص') || s.startsWith('12')).toList();
  } else if (periodKey == 'evening') {
    return slots.where((s) => s.contains('م') && !s.startsWith('12')).toList();
  }
  return slots;
}
