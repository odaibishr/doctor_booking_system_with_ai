import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/usecases/create_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.createProfileUseCase, this.getProfileUseCase)
    : super(ProfileInitial());

  final CreateProfileUseCase createProfileUseCase;
  final GetProfileUseCase getProfileUseCase;

  Future<void> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
    File? imageFile,
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
}
