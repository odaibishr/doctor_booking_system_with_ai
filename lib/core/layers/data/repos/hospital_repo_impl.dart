import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/queries/hospitals_query.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';

class HospitalRepoImpl implements HospitalRepo {
  final HospitalRemoteDataSource remoteDataSource;
  final HospitalLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HospitalRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Hospital>>> getHospitals() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedHospitals = await localDataSource.getCachedHospitals();
        if (cachedHospitals.isEmpty) {
          return Left(Failure('لم يتم العثور على المستشفيات'));
        }

        return Right(cachedHospitals);
      }
      final result = await remoteDataSource.getHospitals();

      if (result.isEmpty) {
        return Left(Failure('لم يتم العثور على المستشفيات'));
      }

      await localDataSource.cachedHospitals(result);

      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, Hospital>> getHospitalDetailes(int id) async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedHospitals = await localDataSource.getCachedHospitals();
        if (cachedHospitals.isEmpty) {
          return Left(Failure('لم يتم العثور على المستشفى'));
        }

        return Right(cachedHospitals.firstWhere((element) => element.id == id));
      }

      final result = await remoteDataSource.getHospitalDetails(id);

      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Hospital>>> watchHospitals() {
    final query = hospitalsQuery();
    final controller = StreamController<Either<Failure, List<Hospital>>>.broadcast();

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
  Future<Either<Failure, void>> refreshHospitals() async {
    try {
      final query = hospitalsQuery();
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
