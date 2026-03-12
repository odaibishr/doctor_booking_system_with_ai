import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class DoctorDashboardLocalDataSource {
  Future<void> saveDashboardData(DashboardStats dashboard);
  Future<DashboardStats?> getCachedDashboard();
}

class DoctorDashboardLocalDataSourceImpl
    implements DoctorDashboardLocalDataSource {
  @override
  Future<DashboardStats?> getCachedDashboard() async {
    final box = Hive.box<DashboardStats>(kDashboardBox);
    return box.get('current_dashboard_stats');
  }

  @override
  Future<void> saveDashboardData(DashboardStats dashboard) async {
    final box = Hive.box<DashboardStats>(kDashboardBox);
    await box.put('current_dashboard_stats', dashboard);
  }
}
