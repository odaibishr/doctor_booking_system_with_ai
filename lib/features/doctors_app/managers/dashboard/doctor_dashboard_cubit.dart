import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:equatable/equatable.dart';

part 'doctor_dashboard_state.dart';

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  final PusherService _pusherService;
  Query<Either<Failure, DashboardStats>>? _dashboardQuery;
  StreamSubscription<QueryState<Either<Failure, DashboardStats>>>? _querySub;
  StreamSubscription? _pusherSub;

  DoctorDashboardCubit(this._pusherService) : super(DoctorDashboardInitial()) {
    _listenToPusher();
  }

  void _listenToPusher() {
    _pusherSub?.cancel();
    _pusherSub = _pusherService.eventStream.listen((event) {
      // Any appointment update should trigger a dashboard refresh
      invalidateDoctorDashboardCache();
      _dashboardQuery?.refetch();
    });
  }

  void _safeEmit(DoctorDashboardState state) {
    if (!isClosed) emit(state);
  }

  void fetchDashboard({String filter = 'all'}) {
    if (isClosed) return;

    _querySub?.cancel();
    _dashboardQuery = doctorDashboardQuery(filter);

    final currentData = _dashboardQuery!.state.data;
    if (currentData != null) {
      currentData.fold(
        (f) => _safeEmit(DoctorDashboardError(f.errorMessage)),
        (stats) => _safeEmit(DoctorDashboardLoaded(stats)),
      );
    } else {
      _safeEmit(DoctorDashboardLoading());
    }

    _querySub = _dashboardQuery!.stream.listen((queryState) {
      if (isClosed) return;
      if (queryState.status == QueryStatus.loading && queryState.data == null) {
        _safeEmit(DoctorDashboardLoading());
        return;
      }
      queryState.data?.fold(
        (f) => _safeEmit(DoctorDashboardError(f.errorMessage)),
        (stats) => _safeEmit(DoctorDashboardLoaded(stats)),
      );
    });
  }

  @override
  Future<void> close() async {
    await _querySub?.cancel();
    _dashboardQuery = null;
    return super.close();
  }
}
