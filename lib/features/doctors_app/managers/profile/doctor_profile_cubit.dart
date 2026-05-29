import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_my_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_profile_image_use_case.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final GetMyProfileUseCase _getMyProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final UpdateProfileImageUseCase _updateProfileImageUseCase;

  DoctorProfileCubit({
    required GetMyProfileUseCase getMyProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required UpdateProfileImageUseCase updateProfileImageUseCase,
  })  : _getMyProfileUseCase = getMyProfileUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        _updateProfileImageUseCase = updateProfileImageUseCase,
        super(DoctorProfileInitial());

  void _safeEmit(DoctorProfileState state) {
    if (!isClosed) emit(state);
  }

  Future<void> fetchProfile() async {
    _safeEmit(DoctorProfileLoading());
    final result = await _getMyProfileUseCase();
    result.fold(
      (failure) => _safeEmit(DoctorProfileError(failure.errorMessage)),
      (doctor) => _safeEmit(DoctorProfileLoaded(doctor)),
    );
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    _safeEmit(DoctorProfileUpdating());
    final result = await _updateProfileUseCase(data);
    result.fold(
      (failure) => _safeEmit(DoctorProfileError(failure.errorMessage)),
      (doctor) => _safeEmit(DoctorProfileLoaded(doctor)),
    );
  }

  Future<void> updateImageOnly(File imageFile) async {
    final result = await _updateProfileImageUseCase(imageFile);
    result.fold(
      (failure) => _safeEmit(DoctorProfileError(failure.errorMessage)),
      (_) {},
    );
  }

  Future<void> updateImage(File imageFile) async {
    final currentState = state;
    _safeEmit(DoctorProfileUpdating());
    final result = await _updateProfileImageUseCase(imageFile);
    result.fold((failure) {
      _safeEmit(DoctorProfileError(failure.errorMessage));
      if (currentState is DoctorProfileLoaded) {
        _safeEmit(currentState);
      }
    }, (_) => fetchProfile());
  }
}
