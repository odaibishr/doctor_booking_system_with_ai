import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';

class DoctorProfileRepoImpl implements DoctorProfileRepo {
  final DoctorProfileRemoteDataSource remoteDataSource;

  DoctorProfileRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Doctor>> getMyProfile() async {
    try {
      final result = await remoteDataSource.getMyProfile();
      return Right(result);
    } catch (e) {
      return Left(Failure('فشل جلب بيانات الملف الشخصي'));
    }
  }

  @override
  Future<Either<Failure, Doctor>> updateProfile(
    Map<String, dynamic> data,
  ) async {
    try {
      final result = await remoteDataSource.updateProfile(data);
      return Right(result);
    } catch (e) {
      return Left(Failure('فشل تحديث البيانات'));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfileImage(File imageFile) async {
    try {
      final path = await remoteDataSource.updateProfileImage(imageFile);
      return Right(path);
    } catch (e) {
      return Left(Failure('فشل تحديث الصورة'));
    }
  }

  @override
  Future<Either<Failure, List<DoctorSchedule>>> getSchedules() async {
    try {
      final result = await remoteDataSource.getSchedules();
      return Right(result);
    } catch (e) {
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
      final result = await remoteDataSource.getDaysOff();
      return Right(result);
    } catch (e) {
      return Left(Failure('فشل جلب أيام الإجازة'));
    }
  }

  @override
  Future<Either<Failure, List<DoctorDayOff>>> createDayOff(
    List<int> dayIds,
  ) async {
    try {
      final result = await remoteDataSource.createDayOff(dayIds);
      return Right(result);
    } catch (e) {
      return Left(Failure('فشل إضافة يوم الإجازة'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDayOff(int id) async {
    try {
      await remoteDataSource.deleteDayOff(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure('فشل حذف يوم الإجازة'));
    }
  }
}
