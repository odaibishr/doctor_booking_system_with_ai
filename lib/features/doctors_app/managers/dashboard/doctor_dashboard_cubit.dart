import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_dashboard_stats_use_case.dart';
import 'package:equatable/equatable.dart';

part 'doctor_dashboard_state.dart';

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  final GetDashboardStatsUseCase _getDashboardStatsUseCase;

  DoctorDashboardCubit(this._getDashboardStatsUseCase)
    : super(DoctorDashboardInitial());

  void _safeEmit(DoctorDashboardState state) {
    if (!isClosed) emit(state);
  }

  Future<void> fetchDashboard({String filter = 'all'}) async {
    if (isClosed) return;

    _safeEmit(DoctorDashboardLoading());
    try {
      final result = await _getDashboardStatsUseCase.call(
        GetDashboardStatsParams(filter: filter),
      );
      result.fold(
        (failure) => _safeEmit(DoctorDashboardError(failure.errorMessage)),
        (stats) => _safeEmit(DoctorDashboardLoaded(stats)),
      );
    } catch (e) {
      _safeEmit(DoctorDashboardError(e.toString()));
    }
  }
}
