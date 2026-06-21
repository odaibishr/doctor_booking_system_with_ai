import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_schedules_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_schedule_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_days_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/create_day_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/delete_day_off_use_case.dart';
import 'doctor_schedule_state.dart';

class DoctorScheduleCubit extends Cubit<DoctorScheduleState> {
  final GetSchedulesUseCase _getSchedulesUseCase;
  final UpdateScheduleUseCase _updateScheduleUseCase;
  final GetDaysOffUseCase _getDaysOffUseCase;
  final CreateDayOffUseCase _createDayOffUseCase;
  final DeleteDayOffUseCase _deleteDayOffUseCase;

  DoctorScheduleCubit({
    required GetSchedulesUseCase getSchedulesUseCase,
    required UpdateScheduleUseCase updateScheduleUseCase,
    required GetDaysOffUseCase getDaysOffUseCase,
    required CreateDayOffUseCase createDayOffUseCase,
    required DeleteDayOffUseCase deleteDayOffUseCase,
  })  : _getSchedulesUseCase = getSchedulesUseCase,
        _updateScheduleUseCase = updateScheduleUseCase,
        _getDaysOffUseCase = getDaysOffUseCase,
        _createDayOffUseCase = createDayOffUseCase,
        _deleteDayOffUseCase = deleteDayOffUseCase,
        super(DoctorScheduleInitial());

  void _safeEmit(DoctorScheduleState state) {
    if (!isClosed) emit(state);
  }

  Future<void> fetchAll() async {
    _safeEmit(DoctorScheduleLoading());
    final schedulesResult = await _getSchedulesUseCase();
    final daysOffResult = await _getDaysOffUseCase();

    schedulesResult.fold(
      (failure) => _safeEmit(DoctorScheduleError(failure.errorMessage)),
      (schedules) {
        daysOffResult.fold(
          (failure) => _safeEmit(DoctorScheduleError(failure.errorMessage)),
          (daysOff) => _safeEmit(
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

    final result = await _updateScheduleUseCase(
      id: id,
      startTime: startTime,
      endTime: endTime,
    );
    result.fold(
      (failure) => _safeEmit(DoctorScheduleError(failure.errorMessage)),
      (updated) {
        final newSchedules = currentState.schedules.map((s) {
          return s.id == id ? updated : s;
        }).toList();
        _safeEmit(
          DoctorScheduleLoaded(
            schedules: newSchedules,
            daysOff: currentState.daysOff,
          ),
        );
      },
    );
  }

  Future<void> addDayOff(List<int> dayIds) async {
    final currentState = state;
    if (currentState is! DoctorScheduleLoaded) return;

    final result = await _createDayOffUseCase(dayIds);
    result.fold(
      (failure) => _safeEmit(DoctorScheduleError(failure.errorMessage)),
      (_) => fetchAll(),
    );
  }

  Future<void> removeDayOff(int id) async {
    final currentState = state;
    if (currentState is! DoctorScheduleLoaded) return;

    final result = await _deleteDayOffUseCase(id);
    result.fold(
      (failure) => _safeEmit(DoctorScheduleError(failure.errorMessage)),
      (_) {
        final newDaysOff = currentState.daysOff
            .where((d) => d.id != id)
            .toList();
        _safeEmit(
          DoctorScheduleLoaded(
            schedules: currentState.schedules,
            daysOff: newDaysOff,
          ),
        );
      },
    );
  }

  Future<void> saveScheduleChanges(List<ScheduleDayChange> changes) async {
    _safeEmit(DoctorScheduleLoading());

    for (final change in changes) {
      if (change.isActive && change.scheduleId != null) {
        await _updateScheduleUseCase(
          id: change.scheduleId!,
          startTime: change.startTime,
          endTime: change.endTime,
        );
      }

      if (!change.isActive &&
          !change.wasOriginallyDayOff &&
          change.hadSchedule) {
        await _createDayOffUseCase([change.dayId]);
      }

      if (change.isActive &&
          change.wasOriginallyDayOff &&
          change.dayOffId != null) {
        await _deleteDayOffUseCase(change.dayOffId!);
      }
    }

    await fetchAll();
  }
}

class ScheduleDayChange {
  final int dayId;
  final bool isActive;
  final int? scheduleId;
  final String startTime;
  final String endTime;
  final int? dayOffId;
  final bool wasOriginallyDayOff;
  final bool hadSchedule;

  const ScheduleDayChange({
    required this.dayId,
    required this.isActive,
    required this.scheduleId,
    required this.startTime,
    required this.endTime,
    required this.dayOffId,
    required this.wasOriginallyDayOff,
    required this.hadSchedule,
  });
}
