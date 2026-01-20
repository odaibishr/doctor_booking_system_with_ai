import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_keys.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';

Query<Either<Failure, List<Doctor>>> doctorsQuery() {
  return Query<Either<Failure, List<Doctor>>>(
    key: QueryKeys.doctors,
    queryFn: () => serviceLocator<DoctorRepo>().getDoctors(),
    config: AppQueryConfig.defaultConfig,
  );
}

Query<Either<Failure, Doctor>> doctorDetailsQuery(int doctorId) {
  return Query<Either<Failure, Doctor>>(
    key: QueryKeys.doctorDetails(doctorId),
    queryFn: () => serviceLocator<DoctorRepo>().getDoctorDetails(doctorId),
    config: AppQueryConfig.defaultConfig,
  );
}

Query<Either<Failure, List<Doctor>>> favoriteDoctorsQuery() {
  return Query<Either<Failure, List<Doctor>>>(
    key: QueryKeys.favoriteDoctors,
    queryFn: () => serviceLocator<DoctorRepo>().getFavoriteDoctors(),
    config: AppQueryConfig.frequentUpdateConfig,
  );
}

void invalidateDoctorsCache() {
  AppQueryConfig.invalidateQuery(QueryKeys.doctors);
}

void invalidateFavoriteDoctorsCache() {
  AppQueryConfig.invalidateQuery(QueryKeys.favoriteDoctors);
}

void invalidateDoctorDetailsCache(int doctorId) {
  AppQueryConfig.invalidateQuery(QueryKeys.doctorDetails(doctorId));
}
