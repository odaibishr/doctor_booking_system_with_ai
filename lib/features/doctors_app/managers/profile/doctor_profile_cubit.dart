import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepo _repo;

  DoctorProfileCubit(this._repo) : super(DoctorProfileInitial());

  Future<void> fetchProfile() async {
    emit(DoctorProfileLoading());
    final result = await _repo.getMyProfile();
    result.fold(
      (failure) => emit(DoctorProfileError(failure.errorMessage)),
      (doctor) => emit(DoctorProfileLoaded(doctor)),
    );
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    emit(DoctorProfileUpdating());
    final result = await _repo.updateProfile(data);
    result.fold(
      (failure) => emit(DoctorProfileError(failure.errorMessage)),
      (doctor) => emit(DoctorProfileLoaded(doctor)),
    );
  }

  Future<void> updateImage(File imageFile) async {
    final currentState = state;
    emit(DoctorProfileUpdating());
    final result = await _repo.updateProfileImage(imageFile);
    result.fold((failure) {
      emit(DoctorProfileError(failure.errorMessage));
      if (currentState is DoctorProfileLoaded) {
        emit(currentState);
      }
    }, (_) => fetchProfile());
  }
}
