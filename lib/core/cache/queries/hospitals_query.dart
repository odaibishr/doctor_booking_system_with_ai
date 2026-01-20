import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_keys.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';

Query<Either<Failure, List<Hospital>>> hospitalsQuery() {
  return Query<Either<Failure, List<Hospital>>>(
    key: QueryKeys.hospitals,
    queryFn: () => serviceLocator<HospitalRepo>().getHospitals(),
    config: AppQueryConfig.rareUpdateConfig,
  );
}

Query<Either<Failure, Hospital>> hospitalDetailsQuery(int hospitalId) {
  return Query<Either<Failure, Hospital>>(
    key: QueryKeys.hospitalDetails(hospitalId),
    queryFn: () =>
        serviceLocator<HospitalRepo>().getHospitalDetailes(hospitalId),
    config: AppQueryConfig.defaultConfig,
  );
}

void invalidateHospitalsCache() {
  AppQueryConfig.invalidateQuery(QueryKeys.hospitals);
}

void invalidateHospitalDetailsCache(int hospitalId) {
  AppQueryConfig.invalidateQuery(QueryKeys.hospitalDetails(hospitalId));
}
