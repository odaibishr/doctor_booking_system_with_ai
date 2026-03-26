part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess({required this.user});
}

final class AuthLoggedOut extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

// Password Reset States
final class ForgotPasswordLoading extends AuthState {}
final class ForgotPasswordSuccess extends AuthState {
  final String message;
  ForgotPasswordSuccess({required this.message});
}
final class ForgotPasswordFailure extends AuthState {
  final String message;
  ForgotPasswordFailure({required this.message});
}

final class VerifyOtpLoading extends AuthState {}
final class VerifyOtpSuccess extends AuthState {
  final String message;
  VerifyOtpSuccess({required this.message});
}
final class VerifyOtpFailure extends AuthState {
  final String message;
  VerifyOtpFailure({required this.message});
}

final class ResetPasswordLoading extends AuthState {}
final class ResetPasswordSuccess extends AuthState {
  final String message;
  ResetPasswordSuccess({required this.message});
}
final class ResetPasswordFailure extends AuthState {
  final String message;
  ResetPasswordFailure({required this.message});
}
