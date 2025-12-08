import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:meta/meta.dart';

part 'favorite_doctor_state.dart';

class FavoriteDoctorCubit extends Cubit<FavoriteDoctorState> {
  FavoriteDoctorCubit() : super(FavoriteDoctorInitial());
}
