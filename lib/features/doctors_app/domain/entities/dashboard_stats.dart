import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/earnings_data.dart';

class DashboardStats {
  final int todayAppointments;
  final int upcomingAppointments;
  final int completedAppointments;
  final int cancelledAppointments;
  final int totalPatients;
  final int todayPatients;
  final EarningsData earnings;
  final int reviewsAvg;
  final int waitlistCount;
  final String? hospitalName;
  final List<DoctorSchedule> workingHours;
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
    required this.waitlistCount,
    this.hospitalName,
    required this.workingHours,
    required this.daysOff,
  });
}
