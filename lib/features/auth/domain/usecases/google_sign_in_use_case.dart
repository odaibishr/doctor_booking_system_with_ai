import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';

class GoogleSignInUseCase extends Usecase<User, GoogleSignInParams> {
  final AuthRepo authRepo;

  GoogleSignInUseCase(this.authRepo);
  @override
  Future<Either<Failure, User>> call([GoogleSignInParams? params]) async {
    return await authRepo.signInWithGoogle(
      name: params!.name,
      email: params.email,
      googleId: params.googleId,
      idToken: params.idToken,
      photoUrl: params.photoUrl,
      fcmToken: params.fcmToken,
    );
  }
}

class GoogleSignInParams {
  final String name;
  final String email;
  final String googleId;
  final String idToken;
  final String? photoUrl;
  final String? fcmToken;

  GoogleSignInParams({
    required this.name,
    required this.email,
    required this.googleId,
    required this.idToken,
    this.photoUrl,
    this.fcmToken,
  });
}
