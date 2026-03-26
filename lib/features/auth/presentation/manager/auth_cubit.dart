import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/check_auth_satus_usecase.dart';

import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/google_sign_in_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/use_cases/logout_use_case.dart'
    as profile_logout;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signInUseCase,
    required this.signUpUsecase,
    required this.checkAuthSatusUsecase,
    required this.logoutUseCase,
    required this.googleSignInUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyOtpUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial());

  final SignInUseCase signInUseCase;
  final SignUpUsecase signUpUsecase;
  final CheckAuthSatusUsecase checkAuthSatusUsecase;
  final profile_logout.LogoutUseCase logoutUseCase;
  final GoogleSignInUseCase googleSignInUseCase;

  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  String? fcmToken;
  void setFcmToken(String? token) {
    fcmToken = token;
  }

  Future<void> signIn({
    required String email,
    required String password,
    String? fcm_token,
  }) async {
    emit(AuthLoading());
    try {
      final result = await signInUseCase(
        SignInParams(email: email, password: password, fcm_token: fcm_token),
      );

      result.fold((failure) => emit(AuthError(message: failure.errorMessage)), (
        user,
      ) async {
        if (user.token.isNotEmpty) {
          await HiveService.cacheAuthData(user);
          emit(AuthSuccess(user: user));
        }
      });
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final result = await googleSignInUseCase();
      result.fold((failure) => emit(AuthError(message: failure.errorMessage)), (
        user,
      ) async {
        if (user.token.isNotEmpty) {
          await HiveService.cacheAuthData(user);
          emit(AuthSuccess(user: user));
        }
      });
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final result = await checkAuthSatusUsecase(NoParams());
      result.fold((failure) => emit(AuthError(message: failure.errorMessage)), (
        user,
      ) {
        if (user != null && user.token.isNotEmpty) {
          emit(AuthSuccess(user: user));
        } else {
          emit(AuthError(message: "لم يتم العثور على مستخدم مسجل الدخول"));
        }
      });
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? fcm_token,
  }) async {
    emit(AuthLoading());
    try {
      final result = await signUpUsecase(
        SignUpParams(
          name: name,
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
          fcmToken: fcm_token,
        ),
      );

      result.fold((failure) => emit(AuthError(message: failure.errorMessage)), (
        user,
      ) {
        if (user.token.isEmpty) {
          emit(AuthError(message: "تم استلام رمز غير صالح"));
        } else {
          emit(AuthSuccess(user: user));
        }
      });
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      final result = await logoutUseCase();
      result.fold(
        (failure) => emit(AuthError(message: failure.errorMessage)),
        (_) => emit(AuthLoggedOut()),
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Forgot Password Methods
  Future<void> forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    try {
      final result = await forgotPasswordUseCase(email);
      result.fold(
        (failure) => emit(ForgotPasswordFailure(message: failure.errorMessage)),
        (message) => emit(ForgotPasswordSuccess(message: message)),
      );
    } catch (e) {
      emit(ForgotPasswordFailure(message: e.toString()));
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    emit(VerifyOtpLoading());
    try {
      final result = await verifyOtpUseCase(
        VerifyOtpParams(email: email, otp: otp),
      );
      result.fold(
        (failure) => emit(VerifyOtpFailure(message: failure.errorMessage)),
        (message) => emit(VerifyOtpSuccess(message: message)),
      );
    } catch (e) {
      emit(VerifyOtpFailure(message: e.toString()));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(ResetPasswordLoading());
    try {
      final result = await resetPasswordUseCase(
        ResetPasswordParams(
          email: email,
          otp: otp,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      );
      result.fold(
        (failure) => emit(ResetPasswordFailure(message: failure.errorMessage)),
        (message) => emit(ResetPasswordSuccess(message: message)),
      );
    } catch (e) {
      emit(ResetPasswordFailure(message: e.toString()));
    }
  }
}
