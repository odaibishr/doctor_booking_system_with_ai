import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';

class DoctorProfileRepoImpl implements DoctorProfileRepo {
  final DoctorProfileRemoteDataSource remoteDataSource;
  final DoctorProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DoctorProfileRepoImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Doctor>> getMyProfile() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedProfile = await localDataSource.getCachedMyProfile();
        if (cachedProfile != null) {
          return Right(cachedProfile);
        }
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }
      final result = await remoteDataSource.getMyProfile();
      await localDataSource.cacheMyProfile(result);
      return Right(result);
    } catch (e) {
      final cachedProfile = await localDataSource.getCachedMyProfile();
      if (cachedProfile != null) {
        return Right(cachedProfile);
      }
      return Left(Failure('فشل جلب بيانات الملف الشخصي'));
    }
  }

  @override
  Future<Either<Failure, Doctor>> updateProfile(
    Map<String, dynamic> data,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت لتحديث البيانات'));
      }
      final result = await remoteDataSource.updateProfile(data);
      await localDataSource.cacheMyProfile(result);
      return Right(result);
    } catch (e) {
      return Left(Failure('فشل تحديث البيانات'));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfileImage(File imageFile) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت لتحديث الصورة'));
      }
      final path = await remoteDataSource.updateProfileImage(imageFile);
      return Right(path);
    } catch (e) {
      return Left(Failure('فشل تحديث الصورة'));
    }
  }

  @override
  Future<Either<Failure, List<DoctorSchedule>>> getSchedules() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedSchedules = await localDataSource.getCachedSchedules();
        if (cachedSchedules.isNotEmpty) {
          return Right(cachedSchedules);
        }
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }
      final result = await remoteDataSource.getSchedules();
      await localDataSource.cacheSchedules(result);
      return Right(result);
    } catch (e) {
      final cachedSchedules = await localDataSource.getCachedSchedules();
      if (cachedSchedules.isNotEmpty) {
        return Right(cachedSchedules);
      }
      return Left(Failure('فشل جلب جدول المواعيد'));
    }
  }

  @override
  Future<Either<Failure, DoctorSchedule>> updateSchedule(
    int id,
    String startTime,
    String endTime,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت لتحديث الجدول'));
      }
      final result = await remoteDataSource.updateSchedule(
        id,
        startTime,
        endTime,
      );
      return Right(result);
    } catch (e) {
      return Left(Failure('فشل تحديث الجدول'));
    }
  }

  @override
  Future<Either<Failure, List<DoctorDayOff>>> getDaysOff() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedDaysOff = await localDataSource.getCachedDaysOff();
        if (cachedDaysOff.isNotEmpty) {
          return Right(cachedDaysOff);
        }
        return Left(Failure('لايوجد اتصال بالانترنت'));
      }
      final result = await remoteDataSource.getDaysOff();
      await localDataSource.cacheDaysOff(result);
      return Right(result);
    } catch (e) {
      final cachedDaysOff = await localDataSource.getCachedDaysOff();
      if (cachedDaysOff.isNotEmpty) {
        return Right(cachedDaysOff);
      }
      return Left(Failure('فشل جلب أيام الإجازة'));
    }
  }

  @override
  Future<Either<Failure, List<DoctorDayOff>>> createDayOff(
    List<int> dayIds,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت لإضافة إجازة'));
      }
      final result = await remoteDataSource.createDayOff(dayIds);
      await localDataSource.cacheDaysOff(result);
      return Right(result);
    } catch (e) {
      return Left(Failure('فشل إضافة يوم الإجازة'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDayOff(int id) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لايوجد اتصال بالانترنت لحذف إجازة'));
      }
      await remoteDataSource.deleteDayOff(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure('فشل حذف يوم الإجازة'));
    }
  }
}
