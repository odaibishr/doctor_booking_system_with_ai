import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_dashboard_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/models/dashboard_stats_model.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_dashboard_repo.dart';

class DoctorDashboardRepoImpl implements DoctorDashboardRepo {
  final DoctorDashboardRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DoctorDashboardRepoImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, DashboardStats>> getDashboardStats({
    String filter = 'all',
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }
      final result = await remoteDataSource.getDashboardStats(filter: filter);
      return Right(DashboardStatsModel.fromMap(result));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
