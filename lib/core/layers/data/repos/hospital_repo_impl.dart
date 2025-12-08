import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';

class HospitalRepoImpl implements HospitalRepo {
  final HospitalRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  HospitalRepoImpl({
    required HospitalRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<Hospital>>> getHospitals() async {
    try {
      final result = await _remoteDataSource.getHospitals();

      if (result.isEmpty) {
        return Left(Failure('لم يتم العثور على المستشفيات'));
      }

      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
