import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_dashboard_stats_use_case.dart';
import 'package:equatable/equatable.dart';

part 'doctor_dashboard_state.dart';

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  final GetDashboardStatsUseCase _getDashboardStatsUseCase;

  DoctorDashboardCubit(this._getDashboardStatsUseCase)
    : super(DoctorDashboardInitial());

  Future<void> fetchDashboard({String filter = 'all'}) async {
    if (isClosed) return;

    emit(DoctorDashboardLoading());
    try {
      final result = await _getDashboardStatsUseCase.call(
        GetDashboardStatsParams(filter: filter),
      );
      result.fold(
        (failure) => emit(DoctorDashboardError(failure.errorMessage)),
        (stats) => emit(DoctorDashboardLoaded(stats)),
      );
    } catch (e) {
      emit(DoctorDashboardError(e.toString()));
    }
  }
}
