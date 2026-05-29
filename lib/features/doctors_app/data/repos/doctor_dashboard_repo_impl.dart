import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/queries/doctor_appointments_query.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_dashboard_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_dashboard_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/models/dashboard_stats_model.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_dashboard_repo.dart';

class DoctorDashboardRepoImpl implements DoctorDashboardRepo {
  final DoctorDashboardRemoteDataSource remoteDataSource;
  final DoctorDashboardLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DoctorDashboardRepoImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, DashboardStats>> getDashboardStats({
    String filter = 'all',
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedDashboard = await localDataSource.getCachedDashboard();
        if (cachedDashboard != null) {
          return Right(cachedDashboard);
        }
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }
      final result = await remoteDataSource.getDashboardStats(filter: filter);
      await localDataSource.saveDashboardData(
        DashboardStatsModel.fromMap(result),
      );
      return Right(DashboardStatsModel.fromMap(result));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Stream<Either<Failure, DashboardStats>> watchDashboardStats(String filter) {
    final query = doctorDashboardQuery(filter);
    final controller = StreamController<Either<Failure, DashboardStats>>.broadcast();

    if (query.state.data != null) {
      controller.add(query.state.data!);
    }

    final subscription = query.stream.listen((state) {
      if (state.data != null) {
        controller.add(state.data!);
      }
    });

    final isStale = query.state.status == QueryStatus.initial ||
        DateTime.now().difference(query.state.timeCreated) >
            AppQueryConfig.defaultRefetchDuration;

    if (isStale) {
      query.refetch();
    }

    controller.onCancel = () {
      subscription.cancel();
      controller.close();
    };

    return controller.stream;
  }

  @override
  Future<Either<Failure, void>> refreshDashboardStats(String filter) async {
    try {
      final query = doctorDashboardQuery(filter);
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
