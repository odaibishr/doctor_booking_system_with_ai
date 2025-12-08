import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class GetFavoriteDoctorsUseCase extends Usecase<List<Doctor>, NoParams>{
  @override
  Future<Either<Failure, List<Doctor>>> call([NoParams? params]) {
    // TODO: implement call
    throw UnimplementedError();
  }
}


class NoParams {}