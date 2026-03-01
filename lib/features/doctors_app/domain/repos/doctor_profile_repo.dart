import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';

abstract class DoctorProfileRepo {
  Future<Either<Failure, Doctor>> getMyProfile();
  Future<Either<Failure, Doctor>> updateProfile(Map<String, dynamic> data);
  Future<Either<Failure, String>> updateProfileImage(File imageFile);
  Future<Either<Failure, List<DoctorSchedule>>> getSchedules();
  Future<Either<Failure, DoctorSchedule>> updateSchedule(
    int id,
    String startTime,
    String endTime,
  );
  Future<Either<Failure, List<DoctorDayOff>>> getDaysOff();
  Future<Either<Failure, List<DoctorDayOff>>> createDayOff(List<int> dayIds);
  Future<Either<Failure, void>> deleteDayOff(int id);
}
