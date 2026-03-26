import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';

class GoogleSignInUseCase extends Usecase<User, NoParams> {

  final AuthRepo authRepo;

  GoogleSignInUseCase(this.authRepo);

  @override
  Future<Either<Failure, User>> call([NoParams? params]) async {
    return await authRepo.signInWithGoogle();
  }
}

