import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/cache/query_keys.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_dashboard_repo.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';

Query<Either<Failure, List<DoctorAppointment>>> doctorTodayAppointmentsQuery() {
  return Query(
    key: QueryKeys.doctorTodayAppointments,
    queryFn: () =>
        serviceLocator<DoctorAppointmentRepo>().getTodayAppointments(),
    config: AppQueryConfig.frequentUpdateConfig,
  );
}

Query<Either<Failure, List<DoctorAppointment>>>
doctorUpcomingAppointmentsQuery() {
  return Query(
    key: QueryKeys.doctorUpcomingAppointments,
    queryFn: () =>
        serviceLocator<DoctorAppointmentRepo>().getUpcomingAppointments(),
    config: AppQueryConfig.frequentUpdateConfig,
  );
}

Query<Either<Failure, List<DoctorAppointment>>>
doctorHistoryAppointmentsQuery() {
  return Query(
    key: QueryKeys.doctorHistoryAppointments,
    queryFn: () =>
        serviceLocator<DoctorAppointmentRepo>().getHistoryAppointments(),
    config: AppQueryConfig.frequentUpdateConfig,
  );
}

Query<Either<Failure, List<DoctorAppointment>>> doctorAppointmentsByStatusQuery(
  String status,
) {
  return Query(
    key: QueryKeys.doctorAppointmentsByStatus(status),
    queryFn: () =>
        serviceLocator<DoctorAppointmentRepo>().getAppointments(status: status),
    config: AppQueryConfig.frequentUpdateConfig,
  );
}

Query<Either<Failure, DashboardStats>> doctorDashboardQuery(String filter) {
  return Query(
    key: QueryKeys.doctorDashboard,
    queryFn: () =>
        serviceLocator<DoctorDashboardRepo>().getDashboardStats(filter: filter),
    config: AppQueryConfig.frequentUpdateConfig,
  );
}

// Invalidation & Optimistic functions
void updateAppointmentOptimisticallyInCache(DoctorAppointment updatedAppointment) {
  final statusKeys = [
    QueryKeys.doctorAppointmentsByStatus('pending'),
    QueryKeys.doctorAppointmentsByStatus('confirmed'),
    QueryKeys.doctorAppointmentsByStatus('completed'),
    QueryKeys.doctorAppointmentsByStatus('cancelled'),
    QueryKeys.doctorHistoryAppointments,
    QueryKeys.doctorUpcomingAppointments,
    QueryKeys.doctorTodayAppointments,
  ];

  for (final key in statusKeys) {
    final query = CachedQuery.instance.getQuery(key) as Query<Either<Failure, List<DoctorAppointment>>>?;
    if (query != null) {
      query.update((oldData) {
        if (oldData == null) return null;
        
        return oldData.map((list) {
          final newList = List<DoctorAppointment>.from(list);
          
          bool shouldBeInThisList = false;
          if (key == QueryKeys.doctorHistoryAppointments) {
            shouldBeInThisList = updatedAppointment.status == 'completed' || updatedAppointment.status == 'cancelled';
          } else if (key == QueryKeys.doctorUpcomingAppointments) {
            shouldBeInThisList = updatedAppointment.status == 'confirmed' || updatedAppointment.status == 'pending';
          } else if (key == QueryKeys.doctorTodayAppointments) {
            shouldBeInThisList = updatedAppointment.status == 'confirmed' || updatedAppointment.status == 'pending';
          } else if (key == QueryKeys.doctorAppointmentsByStatus(updatedAppointment.status)) {
            shouldBeInThisList = true;
          }

          if (shouldBeInThisList) {
            final index = newList.indexWhere((a) => a.id == updatedAppointment.id);
            if (index == -1) {
              newList.insert(0, updatedAppointment);
            } else {
              newList[index] = updatedAppointment;
            }
          } else {
            newList.removeWhere((a) => a.id == updatedAppointment.id);
          }
          return newList;
        });
      });
    }
  }
}


// Invalidation functions
void invalidateDoctorAppointmentsCache() {
  AppQueryConfig.invalidateQuery(QueryKeys.doctorTodayAppointments);
  AppQueryConfig.invalidateQuery(QueryKeys.doctorUpcomingAppointments);
  AppQueryConfig.invalidateQuery(QueryKeys.doctorHistoryAppointments);
  AppQueryConfig.invalidateQuery(QueryKeys.doctorAppointmentsByStatus('pending'));
  AppQueryConfig.invalidateQuery(QueryKeys.doctorAppointmentsByStatus('confirmed'));
  AppQueryConfig.invalidateQuery(QueryKeys.doctorAppointmentsByStatus('completed'));
  AppQueryConfig.invalidateQuery(QueryKeys.doctorAppointmentsByStatus('cancelled'));
}

void invalidateDoctorAppointmentsByStatusCache(String status) {
  AppQueryConfig.invalidateQuery(QueryKeys.doctorAppointmentsByStatus(status));
}

void invalidateDoctorDashboardCache() {
  AppQueryConfig.invalidateQuery(QueryKeys.doctorDashboard);
}
