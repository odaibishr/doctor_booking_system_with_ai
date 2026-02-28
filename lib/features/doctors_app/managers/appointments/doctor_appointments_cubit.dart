import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  DoctorAppointmentsCubit() : super(DoctorAppointmentsInitial());
}
