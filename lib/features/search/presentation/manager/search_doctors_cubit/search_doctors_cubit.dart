import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/search/domain/usecases/search_doctors_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_doctors_state.dart';

class SearchQuery {
  final String query;
  final int? specialtyId;

  SearchQuery({this.query = '', this.specialtyId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchQuery &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          specialtyId == other.specialtyId;

  @override
  int get hashCode => query.hashCode ^ specialtyId.hashCode;
}

class SearchDoctorsCubit extends Cubit<SearchDoctorsState> {
  final SearchDoctorsUseCase searchDoctorsUseCase;
  final GetDoctorsUseCase getDoctorsUseCase;
  final _searchSubject = BehaviorSubject<SearchQuery>();
  late final StreamSubscription<void> _subscription;
  SearchDoctorsCubit(this.searchDoctorsUseCase, this.getDoctorsUseCase)
    : super(SearchDoctorsInitial()) {
    _subscription = _searchSubject.stream
        .debounceTime(const Duration(milliseconds: 300))
        .distinctUnique()
        .switchMap((searchQuery) => _performSearch(searchQuery))
        .listen((_) {});
  }

  Stream<void> _performSearch(SearchQuery searchQuery) async* {
    emit(SearchDoctorloading());

    if (searchQuery.query.trim().isEmpty && searchQuery.specialtyId == null) {
      final result = await getDoctorsUseCase(NoParams());
      result.fold(
        (failure) => emit(SearchDoctorsError(failure.errorMessage)),
        (doctors) => emit(SearchDoctorsLoaded(doctors)),
      );
    } else {
      final result = await searchDoctorsUseCase(
        SearchDoctorsUseCaseParams(
          query: searchQuery.query,
          specialtyId: searchQuery.specialtyId,
        ),
      );
      result.fold(
        (failure) => emit(SearchDoctorsError(failure.errorMessage)),
        (doctors) => emit(SearchDoctorsLoaded(doctors)),
      );
    }
  }

  void updateSearch(String query, int? specialtyId) {
    _searchSubject.add(SearchQuery(query: query, specialtyId: specialtyId));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    _searchSubject.close();
    return super.close();
  }
}
