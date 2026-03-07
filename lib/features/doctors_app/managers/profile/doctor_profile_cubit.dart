import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepo _repo;

  DoctorProfileCubit(this._repo) : super(DoctorProfileInitial());

  void _safeEmit(DoctorProfileState state) {
    if (!isClosed) emit(state);
  }

  Future<void> fetchProfile() async {
    _safeEmit(DoctorProfileLoading());
    final result = await _repo.getMyProfile();
    result.fold(
      (failure) => _safeEmit(DoctorProfileError(failure.errorMessage)),
      (doctor) => _safeEmit(DoctorProfileLoaded(doctor)),
    );
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    _safeEmit(DoctorProfileUpdating());
    final result = await _repo.updateProfile(data);
    result.fold(
      (failure) => _safeEmit(DoctorProfileError(failure.errorMessage)),
      (doctor) => _safeEmit(DoctorProfileLoaded(doctor)),
    );
  }

  Future<void> updateImageOnly(File imageFile) async {
    final result = await _repo.updateProfileImage(imageFile);
    result.fold(
      (failure) => _safeEmit(DoctorProfileError(failure.errorMessage)),
      (_) {},
    );
  }

  Future<void> updateImage(File imageFile) async {
    final currentState = state;
    _safeEmit(DoctorProfileUpdating());
    final result = await _repo.updateProfileImage(imageFile);
    result.fold((failure) {
      _safeEmit(DoctorProfileError(failure.errorMessage));
      if (currentState is DoctorProfileLoaded) {
        _safeEmit(currentState);
      }
    }, (_) => fetchProfile());
  }
}
