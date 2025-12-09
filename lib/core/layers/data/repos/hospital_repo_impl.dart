import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';

class HospitalRepoImpl implements HospitalRepo {
  final HospitalRemoteDataSource remoteDataSource;
  final HospitalLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HospitalRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Hospital>>> getHospitals() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedHospitals = await localDataSource.getCachedHospitals();
        if (cachedHospitals.isEmpty) {
          return Left(Failure('لم يتم العثور على المستشفيات'));
        }

        return Right(cachedHospitals);
      }
      final result = await remoteDataSource.getHospitals();

      if (result.isEmpty) {
        return Left(Failure('لم يتم العثور على المستشفيات'));
      }

      await localDataSource.cachedHospitals(result);

      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
