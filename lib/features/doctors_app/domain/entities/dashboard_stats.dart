import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/earnings_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'dashboard_stats.g.dart';

@HiveType(typeId: 15)
class DashboardStats {
  @HiveField(0)
  final int todayAppointments;
  @HiveField(1)
  final int upcomingAppointments;
  @HiveField(2)
  final int completedAppointments;
  @HiveField(3)
  final int cancelledAppointments;
  @HiveField(4)
  final int totalPatients;
  @HiveField(5)
  final int todayPatients;
  @HiveField(6)
  final EarningsData earnings;
  @HiveField(7)
  final int reviewsAvg;
  @HiveField(8)
  final int reviewsCount;
  @HiveField(9)
  final int waitlistCount;
  @HiveField(10)
  final String? hospitalName;
  @HiveField(11)
  final List<DoctorSchedule> workingHours;
  @HiveField(12)
  final List<Map<String, dynamic>> daysOff;

  DashboardStats({
    required this.todayAppointments,
    required this.upcomingAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.totalPatients,
    required this.todayPatients,
    required this.earnings,
    required this.reviewsAvg,
    required this.reviewsCount,
    required this.waitlistCount,
    this.hospitalName,
    required this.workingHours,
    required this.daysOff,
  });
}
