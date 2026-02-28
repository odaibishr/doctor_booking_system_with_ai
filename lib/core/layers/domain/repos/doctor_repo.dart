import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';

abstract class DoctorRepo {
  Future<Either<Failure, List<Doctor>>> getDoctors();
  Future<Either<Failure, Doctor>> getDoctorDetails(int id);
  Future<Either<Failure, List<Doctor>>> searchDoctors(
    String query,
    int? specialtyId,
  );
  Future<Either<Failure, bool>> toggleFavoriteDoctor(int doctorId);
  Future<Either<Failure, List<Doctor>>> getFavoriteDoctors();
  Future<Either<Failure, Doctor>> getMyProfile();
  Future<Either<Failure, Doctor>> updateMyProfile(Map<String, dynamic> data);
  Future<Either<Failure, String>> updateMyProfileImage(File imageFile);
  Future<Either<Failure, DoctorSchedule>> getMySchedules();
}
