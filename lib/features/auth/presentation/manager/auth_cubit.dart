import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/check_auth_satus_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/use_cases/logout_use_case.dart'
    as profile_logout;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signInUseCase,
    required this.signUpUsecase,
    required this.checkAuthSatusUsecase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  final SignInUseCase signInUseCase;
  final SignUpUsecase signUpUsecase;
  final CheckAuthSatusUsecase checkAuthSatusUsecase;
  final profile_logout.LogoutUseCase logoutUseCase;

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final result = await signInUseCase(
        SignInParams(email: email, password: password),
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

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final cachedUser = HiveService.getCachedAuthData();
      if (cachedUser != null && cachedUser.token.isNotEmpty) {
        emit(AuthSuccess(user: cachedUser));
      } else {
        emit(AuthError(message: "No logged in user found"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoading());
    try {
      final result = await signUpUsecase(
        SignUpParams(
          name: name,
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      );

      result.fold((failure) => emit(AuthError(message: failure.errorMessage)), (
        user,
      ) {
        if (user.token.isEmpty) {
          emit(AuthError(message: "Invalid token received"));
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
}
