import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';

class SignInUseCase extends Usecase<User, SignInParams> {
  final AuthRepo authRepo;

  SignInUseCase(this.authRepo);

  @override
  Future<Either<Failure, User>> call([SignInParams? params]) async {
    return await authRepo.signIn(params!.email, params.password, params.fcm_token);
  }
}

class SignInParams {
  final String email;
  final String password;
  final String? fcm_token;

  SignInParams({required this.email, required this.password, this.fcm_token});
}
