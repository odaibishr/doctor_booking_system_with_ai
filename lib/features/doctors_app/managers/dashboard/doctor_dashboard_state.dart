part of 'doctor_dashboard_cubit.dart';

sealed class DoctorDashboardState extends Equatable {
  const DoctorDashboardState();

  @override
  List<Object> get props => [];
}

final class DoctorDashboardInitial extends DoctorDashboardState {}

final class DoctorDashboardLoading extends DoctorDashboardState {}

final class DoctorDashboardLoaded extends DoctorDashboardState {
  final DashboardStats stats;

  const DoctorDashboardLoaded(this.stats);
}

final class DoctorDashboardError extends DoctorDashboardState {
  final String message;

  const DoctorDashboardError(this.message);
}
