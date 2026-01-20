import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/usecases/create_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/use_cases/logout_use_case.dart'
    hide NoParams;
import 'package:flutter/foundation.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.createProfileUseCase,
    this.getProfileUseCase,
    this.logoutUseCase,
  ) : super(ProfileInitial());

  final CreateProfileUseCase createProfileUseCase;
  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;

  Future<void> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
    File? imageFile,
    String? name,
    String? email,
    String? password,
  }) async {
    emit(ProfileLoading());
    try {
      final result = await createProfileUseCase(
        CreateProfileParams(
          phone: phone,
          birthDate: birthDate,
          gender: gender,
          locationId: locationId,
          imageFile: imageFile,
          name: name,
          email: email,
          password: password,
        ),
      );

      result.fold(
        (faiure) => emit(ProfileFailure(faiure.errorMessage)),
        (profile) => emit(ProfileSuccess(profile)),
      );
    } catch (error) {
      emit(ProfileFailure(error.toString()));
    }
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final result = await getProfileUseCase(NoParams());
      result.fold(
        (faiure) => emit(ProfileFailure(faiure.errorMessage)),
        (profile) => emit(ProfileSuccess(profile)),
      );
    } catch (error) {
      emit(ProfileFailure(error.toString()));
    }
  }

  Future<void> logout() async {
    emit(ProfileLoading());
    await logoutUseCase();
  }
}
