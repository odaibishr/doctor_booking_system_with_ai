import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/check_auth_satus_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/google_sign_in_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/use_cases/logout_use_case.dart'
    as profile_logout;
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUsecase signUpUsecase;
  final CheckAuthSatusUsecase checkAuthSatusUsecase;
  final profile_logout.LogoutUseCase logoutUseCase;
  final GoogleSignInUseCase googleSignInUseCase;
  final PusherService pusherService;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUsecase,
    required this.checkAuthSatusUsecase,
    required this.logoutUseCase,
    required this.googleSignInUseCase,
    required this.pusherService,
  }) : super(AuthInitial());

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
          await _initPusher(user);
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
          await _initPusher(user);
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
        await _initPusher(cachedUser);
        emit(AuthSuccess(user: cachedUser));
      } else {
        emit(AuthError(message: "لم يتم العثور على مستخدم مسجل الدخول"));
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
      ) async {
        if (user.token.isEmpty) {
          emit(AuthError(message: "تم استلام رمز غير صالح"));
        } else {
          await _initPusher(user);
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
        (_) {
          pusherService.disconnect();
          emit(AuthLoggedOut());
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _initPusher(User user) async {
    await pusherService.init(
      apiKey: dotenv.env['PUSHER_APP_KEY'] ?? '',
      cluster: dotenv.env['PUSHER_APP_CLUSTER'] ?? 'mt1',
      userId: user.id.toString(),
      doctorId: user.doctorId?.toString(),
      token: user.token,
    );
  }
}
