import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/queries/doctor_appointments_query.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_appointment_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_appointment_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class DoctorAppointmentRepoImpl implements DoctorAppointmentRepo {
  final DoctorAppointmentRemoteDataSource remoteDataSource;
  final DoctorAppointmentLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DoctorAppointmentRepoImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<DoctorAppointment>>> getAppointments({
    String? status,
    String? date,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedAppointments = await localDataSource.getCachedAppointments(
          'all_appointments',
        );
        if (cachedAppointments.isNotEmpty) {
          return Right(cachedAppointments);
        }
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getAppointments(
        status: status,
        date: date,
      );
      await localDataSource.cacheAppointments('all_appointments', result);
      return Right(result);
    } catch (error) {
      final cachedAppointments = await localDataSource.getCachedAppointments(
        'all_appointments',
      );
      if (cachedAppointments.isNotEmpty) {
        return Right(cachedAppointments);
      }
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorAppointment>> getAppointmentDetails(
    int id,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedAppointment = await localDataSource.getCachedAppointments(
          'all_appointments',
        );
        if (cachedAppointment.isNotEmpty) {
          try {
            return Right(
              cachedAppointment.firstWhere((element) => element.id == id),
            );
          } catch (_) {
            return Left(
              Failure('لايوجد تفاصيل للحجز في وضع عدم الإتصال بالانترنت'),
            );
          }
        }
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getAppointmentDetails(id);
      return Right(result);
    } catch (error) {
      final cachedAppointment = await localDataSource.getCachedAppointments(
        'all_appointments',
      );
      if (cachedAppointment.isNotEmpty) {
        try {
          return Right(
            cachedAppointment.firstWhere((element) => element.id == id),
          );
        } catch (_) {}
      }
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorAppointment>>>
  getHistoryAppointments() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedAppointments = await localDataSource.getCachedAppointments(
          'history_appointments',
        );
        if (cachedAppointments.isNotEmpty) {
          return Right(cachedAppointments);
        }
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getHistoryAppointments();
      await localDataSource.cacheAppointments('history_appointments', result);
      return Right(result);
    } catch (error) {
      final cachedAppointments = await localDataSource.getCachedAppointments(
        'history_appointments',
      );
      if (cachedAppointments.isNotEmpty) {
        return Right(cachedAppointments);
      }
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorAppointment>>>
  getTodayAppointments() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedAppointments = await localDataSource.getCachedAppointments(
          'today_appointments',
        );
        if (cachedAppointments.isNotEmpty) {
          return Right(cachedAppointments);
        }
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getTodayAppointments();
      await localDataSource.cacheAppointments('today_appointments', result);
      return Right(result);
    } catch (error) {
      final cachedAppointments = await localDataSource.getCachedAppointments(
        'today_appointments',
      );
      if (cachedAppointments.isNotEmpty) {
        return Right(cachedAppointments);
      }
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorAppointment>>>
  getUpcomingAppointments() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedAppointments = await localDataSource.getCachedAppointments(
          'upcoming_appointments',
        );
        if (cachedAppointments.isNotEmpty) {
          return Right(cachedAppointments);
        }
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.getUpcomingAppointments();
      await localDataSource.cacheAppointments('upcoming_appointments', result);
      return Right(result);
    } catch (error) {
      final cachedAppointments = await localDataSource.getCachedAppointments(
        'upcoming_appointments',
      );
      if (cachedAppointments.isNotEmpty) {
        return Right(cachedAppointments);
      }
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorAppointment>> updateAppointmentStatus({
    required int id,
    required String status,
    String? cancellationReason,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }

      final result = await remoteDataSource.updateAppointmentStatus(
        id: id,
        status: status,
        cancellationReason: cancellationReason,
      );
      
      // Perform optimistic cache updates and invalidations in the Data layer
      updateAppointmentOptimisticallyInCache(result);
      invalidateDoctorAppointmentsCache();
      invalidateDoctorDashboardCache();
      
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<DoctorAppointment>>> watchTodayAppointments() {
    final query = doctorTodayAppointmentsQuery();
    final controller = StreamController<Either<Failure, List<DoctorAppointment>>>.broadcast();

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
  Future<Either<Failure, void>> refreshTodayAppointments() async {
    try {
      final query = doctorTodayAppointmentsQuery();
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<DoctorAppointment>>> watchUpcomingAppointments() {
    final query = doctorUpcomingAppointmentsQuery();
    final controller = StreamController<Either<Failure, List<DoctorAppointment>>>.broadcast();

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
  Future<Either<Failure, void>> refreshUpcomingAppointments() async {
    try {
      final query = doctorUpcomingAppointmentsQuery();
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<DoctorAppointment>>> watchHistoryAppointments() {
    final query = doctorHistoryAppointmentsQuery();
    final controller = StreamController<Either<Failure, List<DoctorAppointment>>>.broadcast();

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
  Future<Either<Failure, void>> refreshHistoryAppointments() async {
    try {
      final query = doctorHistoryAppointmentsQuery();
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<DoctorAppointment>>> watchAppointmentsByStatus(String status) {
    final query = doctorAppointmentsByStatusQuery(status);
    final controller = StreamController<Either<Failure, List<DoctorAppointment>>>.broadcast();

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
  Future<Either<Failure, void>> refreshAppointmentsByStatus(String status) async {
    try {
      final query = doctorAppointmentsByStatusQuery(status);
      await query.refetch();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
