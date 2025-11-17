import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';

class SignUpUsecase extends Usecase<User, SignUpParams> {
  final AuthRepo authRepo;

  SignUpUsecase(this.authRepo);

  @override
  Future<Either<Failure, User>> call([SignUpParams? params]) async {
    return await authRepo.signUp(params!.name, params.email, params.password);
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
