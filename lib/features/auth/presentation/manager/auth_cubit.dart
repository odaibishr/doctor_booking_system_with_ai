import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/check_auth_satus_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signInUseCase,
    required this.signUpUsecase,
    required this.checkAuthSatusUsecase,
  }) : super(AuthInitial());

  final SignInUseCase signInUseCase;
  final SignUpUsecase signUpUsecase;
  final CheckAuthSatusUsecase checkAuthSatusUsecase;

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

  Future<void> signUp(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await signUpUsecase(
        SignUpParams(name: name, email: email, password: password),
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
}
