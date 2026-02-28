import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_schedule_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/models/earnings_data_model.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';

class DashboardStatsModel extends DashboardStats {
  DashboardStatsModel({
    required super.todayAppointments,
    required super.upcomingAppointments,
    required super.completedAppointments,
    required super.cancelledAppointments,
    required super.totalPatients,
    required super.todayPatients,
    required super.earnings,
    required super.reviewsAvg,
    required super.waitlistCount,
    required super.workingHours,
    required super.daysOff,
    required super.hospitalName,
    required super.reviewsCount,
  });

  factory DashboardStatsModel.fromMap(Map<String, dynamic> map) {
    final earningsMap = map['earnings'] is Map
        ? map['earnings'] as Map<String, dynamic>
        : <String, dynamic>{};
    List<DoctorSchedule> schedules = [];
    if (map['working_hours'] is List) {
      schedules = (map['working_hours'] as List)
          .map((e) => DoctorScheduleModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    List<Map<String, dynamic>> daysOffList = [];
    if (map['days_off'] is List) {
      daysOffList = (map['days_off'] as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    }
    return DashboardStatsModel(
      todayAppointments: parseToInt(map['today_appointments']),
      upcomingAppointments: parseToInt(map['upcoming_appointments']),
      completedAppointments: parseToInt(map['completed_appointments']),
      cancelledAppointments: parseToInt(map['cancelled_appointments']),
      totalPatients: parseToInt(map['total_patients']),
      todayPatients: parseToInt(map['today_patients']),
      earnings: EarningsDataModel.fromMap(earningsMap),
      reviewsAvg: parseToInt(map['reviews_avg']),
      reviewsCount: parseToInt(map['reviews_count']),
      waitlistCount: parseToInt(map['waitlist_count']),
      hospitalName: map['hospital']?.toString(),
      workingHours: schedules,
      daysOff: daysOffList,
    );
  }
}
