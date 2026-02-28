// This class is used to get current doctor's dashboard stats

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_dashboard_repo.dart';

class GetDashboardStatsUseCase
    extends Usecase<DashboardStats, GetDashboardStatsParams> {
  final DoctorDashboardRepo doctorDashboardRepo;

  GetDashboardStatsUseCase(this.doctorDashboardRepo);

  @override
  Future<Either<Failure, DashboardStats>> call([
    GetDashboardStatsParams? params,
  ]) {
    return doctorDashboardRepo.getDashboardStats(
      filter: params?.filter ?? 'all',
    );
  }
}

class GetDashboardStatsParams {
  final String filter;

  const GetDashboardStatsParams({required this.filter});
}
