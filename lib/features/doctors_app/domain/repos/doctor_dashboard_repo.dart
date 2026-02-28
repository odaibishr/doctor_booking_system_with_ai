import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';

abstract class DoctorDashboardRepo {
  Future<Either<Failure, DashboardStats>> getDashboardStats({
    String filter = 'all',
  });
}
