import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';
import 'package:meta/meta.dart';

part 'specialty_state.dart';

class SpecialtyCubit extends Cubit<SpecialtyState> {
  SpecialtyCubit() : super(SpecialtyInitial());
}
