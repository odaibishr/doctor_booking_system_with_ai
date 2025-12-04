import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, bool>> toggleFavorite(int doctorId);
  Future<Either<Failure, bool>> isFavorite(int doctorId);
}
