import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/services/fcm_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:equatable/equatable.dart';

part 'doctor_dashboard_state.dart';

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  final PusherService _pusherService;
  final FcmService _fcmService;
  Query<Either<Failure, DashboardStats>>? _dashboardQuery;
  StreamSubscription<QueryState<Either<Failure, DashboardStats>>>? _querySub;
  StreamSubscription? _pusherSub;
  StreamSubscription? _fcmSub;

  DoctorDashboardCubit(this._pusherService, this._fcmService)
      : super(DoctorDashboardInitial()) {
    _listenToPusher();
    _listenToFcm();
  }

  void _listenToPusher() {
    _pusherSub?.cancel();
    _pusherSub = _pusherService.eventStream.listen((event) {
      log('DoctorDashboardCubit: REAL-TIME EVENT RECEIVED! $event');
      // Any appointment update should trigger a dashboard refresh
      invalidateDoctorDashboardCache();
      _dashboardQuery?.refetch();
    });
  }

  void _listenToFcm() {
    _fcmSub?.cancel();
    _fcmSub = _fcmService.eventStream.listen((data) {
      log('DoctorDashboardCubit: REAL-TIME FCM EVENT RECEIVED! $data');
      final type = data['type']?.toString();
      if (type == 'appointment_created' || type == 'appointment_updated') {
        log('DoctorDashboardCubit: Triggering refetch from FCM...');
        invalidateDoctorDashboardCache();
        _dashboardQuery?.refetch();
      }
    });
  }

  void _safeEmit(DoctorDashboardState state) {
    if (!isClosed) emit(state);
  }

  void fetchDashboard({String filter = 'today'}) {
    final query = doctorDashboardQuery(filter);
    _listenToQuery(query);
  }

  void _listenToQuery(Query<Either<Failure, DashboardStats>> query) {
    _querySub?.cancel();
    _dashboardQuery = query;

    final currentData = query.state.data;
    if (currentData != null) {
      currentData.fold(
        (f) => _safeEmit(DoctorDashboardError(f.errorMessage)),
        (stats) => _safeEmit(DoctorDashboardLoaded(stats)),
      );
    } else {
      _safeEmit(DoctorDashboardLoading());
    }

    _querySub = query.stream.listen((queryState) {
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

    query.result;
  }

  @override
  Future<void> close() async {
    await _querySub?.cancel();
    await _pusherSub?.cancel();
    await _fcmSub?.cancel();
    _dashboardQuery = null;
    return super.close();
  }
}
