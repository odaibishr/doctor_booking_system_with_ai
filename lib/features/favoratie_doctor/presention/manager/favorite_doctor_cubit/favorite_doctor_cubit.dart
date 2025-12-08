import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';

part 'favorite_doctor_state.dart';

class FavoriteDoctorCubit extends Cubit<FavoriteDoctorState> {
  final GetDoctorsUseCase getDoctorsUseCase;
  FavoriteDoctorCubit(this.getDoctorsUseCase) : super(FavoriteDoctorInitial());

  
}
