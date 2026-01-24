import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_config.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_keys.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';

Query<Either<Failure, List<Specialty>>> specialtiesQuery() {
  return Query<Either<Failure, List<Specialty>>>(
    key: QueryKeys.specialties,
    queryFn: () => serviceLocator<SpecialtyRepo>().getSpecialties(),
    config: AppQueryConfig.rareUpdateConfig,
  );
}

Query<Either<Failure, List<Specialty>>> allSpecialtiesQuery() {
  return Query<Either<Failure, List<Specialty>>>(
    key: QueryKeys.allSpecialties,
    queryFn: () => serviceLocator<SpecialtyRepo>().getAllSpecialties(),
    config: AppQueryConfig.rareUpdateConfig,
  );
}

void invalidateSpecialtiesCache() {
  AppQueryConfig.invalidateQuery(QueryKeys.specialties);
}

void invalidateAllSpecialtiesCache() {
  AppQueryConfig.invalidateQuery(QueryKeys.allSpecialties);
}
