import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/usecases/create_profile_use_case.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.createProfileUseCase) : super(ProfileInitial());

  final CreateProfileUseCase createProfileUseCase;

  Future<void> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
  }) async {
    emit(ProfileLoading());
    try {
      final result = await createProfileUseCase(
        CreateProfileParams(
          phone: phone,
          birthDate: birthDate,
          gender: gender,
          locationId: locationId,
        ),
      );

      result.fold(
        (faiure) => emit(ProfileFailure(faiure.errorMessage)),
        (_) => emit(ProfileSuccess()),
      );
    } catch (error) {
      emit(ProfileFailure(error.toString()));
    }
  }
}
