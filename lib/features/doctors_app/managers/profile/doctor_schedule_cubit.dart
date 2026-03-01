import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';
import 'doctor_schedule_state.dart';

class DoctorScheduleCubit extends Cubit<DoctorScheduleState> {
  final DoctorProfileRepo _repo;

  DoctorScheduleCubit(this._repo) : super(DoctorScheduleInitial());

  Future<void> fetchAll() async {
    emit(DoctorScheduleLoading());
    final schedulesResult = await _repo.getSchedules();
    final daysOffResult = await _repo.getDaysOff();

    schedulesResult.fold(
      (failure) => emit(DoctorScheduleError(failure.errorMessage)),
      (schedules) {
        daysOffResult.fold(
          (failure) => emit(DoctorScheduleError(failure.errorMessage)),
          (daysOff) => emit(
            DoctorScheduleLoaded(schedules: schedules, daysOff: daysOff),
          ),
        );
      },
    );
  }

  Future<void> updateScheduleTime(
    int id,
    String startTime,
    String endTime,
  ) async {
    final currentState = state;
    if (currentState is! DoctorScheduleLoaded) return;

    final result = await _repo.updateSchedule(id, startTime, endTime);
    result.fold((failure) => emit(DoctorScheduleError(failure.errorMessage)), (
      updated,
    ) {
      final newSchedules = currentState.schedules.map((s) {
        return s.id == id ? updated : s;
      }).toList();
      emit(
        DoctorScheduleLoaded(
          schedules: newSchedules,
          daysOff: currentState.daysOff,
        ),
      );
    });
  }

  Future<void> addDayOff(List<int> dayIds) async {
    final currentState = state;
    if (currentState is! DoctorScheduleLoaded) return;

    final result = await _repo.createDayOff(dayIds);
    result.fold(
      (failure) => emit(DoctorScheduleError(failure.errorMessage)),
      (_) => fetchAll(),
    );
  }

  Future<void> removeDayOff(int id) async {
    final currentState = state;
    if (currentState is! DoctorScheduleLoaded) return;

    final result = await _repo.deleteDayOff(id);
    result.fold((failure) => emit(DoctorScheduleError(failure.errorMessage)), (
      _,
    ) {
      final newDaysOff = currentState.daysOff.where((d) => d.id != id).toList();
      emit(
        DoctorScheduleLoaded(
          schedules: currentState.schedules,
          daysOff: newDaysOff,
        ),
      );
    });
  }
}
