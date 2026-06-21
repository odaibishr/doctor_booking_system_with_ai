import 'dart:async';
import 'dart:developer';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/queries/specialties_query.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/specialty_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/specialty_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';

class SpecialtyRepoImpl implements SpecialtyRepo {
  final SpecialtyRemoteDataSource remoteDataSource;
  final SpecialtyLocalDataSource localDataSource;
  final NetworkInfo _networkInfo;

  SpecialtyRepoImpl(
    this.remoteDataSource,
    this.localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, List<Specialty>>> getSpecialties() async {
    try {
      if (!await _networkInfo.isConnected) {
        final cachedSpecialties = await localDataSource.getSpecialties();
        return Right(cachedSpecialties);
      }

      log("Fetching active specialties from remote data source");

      final result = await remoteDataSource.getSpecialties();
      await localDataSource.cachedSpecialties(result);

      log(
        "Fetched ${result.length} active specialties from remote data source",
      );
      return Right(result);
    } catch (error) {
      log('Error fetching specialties: $error');
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Specialty>>> getAllSpecialties() async {
    try {
      if (!await _networkInfo.isConnected) {
        final cachedSpecialties = await localDataSource.getSpecialties();
        return Right(cachedSpecialties);
      }

      log("Fetching all specialties from remote data source");

      final result = await remoteDataSource.getAllSpecialties();

      log("Fetched ${result.length} specialties (all) from remote data source");
      return Right(result);
    } catch (error) {
      log('Error fetching all specialties: $error');
      return Left(Failure(error.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Specialty>>> watchSpecialties() {
    final query = specialtiesQuery();
    final controller = StreamController<Either<Failure, List<Specialty>>>.broadcast();

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
  Future<Either<Failure, void>> refreshSpecialties() async {
    try {
      final query = specialtiesQuery();
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Specialty>>> watchAllSpecialties() {
    final query = allSpecialtiesQuery();
    final controller = StreamController<Either<Failure, List<Specialty>>>.broadcast();

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
  Future<Either<Failure, void>> refreshAllSpecialties() async {
    try {
      final query = allSpecialtiesQuery();
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
