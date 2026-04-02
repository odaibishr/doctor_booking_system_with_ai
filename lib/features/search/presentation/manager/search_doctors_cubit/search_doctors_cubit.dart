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
  final String? gender;
  final double? minPrice;
  final double? maxPrice;
  final int? hospitalId;

  SearchQuery({
    this.query = '',
    this.specialtyId,
    this.gender,
    this.minPrice,
    this.maxPrice,
    this.hospitalId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchQuery &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          specialtyId == other.specialtyId &&
          gender == other.gender &&
          minPrice == other.minPrice &&
          maxPrice == other.maxPrice &&
          hospitalId == other.hospitalId;

  @override
  int get hashCode =>
      query.hashCode ^
      specialtyId.hashCode ^
      gender.hashCode ^
      minPrice.hashCode ^
      maxPrice.hashCode ^
      hospitalId.hashCode;
}

class SearchDoctorsCubit extends Cubit<SearchDoctorsState> {
  final SearchDoctorsUseCase searchDoctorsUseCase;
  final GetDoctorsUseCase getDoctorsUseCase;

  final _searchSubject = BehaviorSubject<SearchQuery>();
  late final StreamSubscription<void> _subscription;

  String _currentQuery = '';
  int? _currentSpecialtyId;

  SearchDoctorsCubit(this.searchDoctorsUseCase, this.getDoctorsUseCase)
      : super(SearchDoctorsInitial()) {
    _subscription = _searchSubject.stream
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap((searchQuery) => _performSearch(searchQuery))
        .listen((state) {
      if (!isClosed) emit(state);
    });
  }

  void updateSearch(String query, [int? specialtyId]) {
    if (isClosed) return;
    emit(SearchDoctorloading());
    _currentQuery = query;
    _currentSpecialtyId = specialtyId ?? _currentSpecialtyId;
    _searchSubject.add(SearchQuery(
      query: query,
      specialtyId: _currentSpecialtyId,
    ));
  }

  void applyFilters({
    String? gender,
    double? minPrice,
    double? maxPrice,
    int? hospitalId,
    int? specialtyId,
  }) {
    if (isClosed) return;
    emit(SearchDoctorloading());
    _currentSpecialtyId = specialtyId;
    _searchSubject.add(SearchQuery(
      query: _currentQuery,
      specialtyId: specialtyId,
      gender: gender,
      minPrice: minPrice,
      maxPrice: maxPrice,
      hospitalId: hospitalId,
    ));
  }

  Stream<SearchDoctorsState> _performSearch(SearchQuery searchQuery) async* {
    yield SearchDoctorloading();

    final bool hasFilters = searchQuery.gender != null ||
        searchQuery.minPrice != null ||
        searchQuery.maxPrice != null ||
        searchQuery.hospitalId != null;

    if (searchQuery.query.trim().isEmpty &&
        searchQuery.specialtyId == null &&
        !hasFilters) {
      final result = await getDoctorsUseCase(NoParams());
      yield result.fold(
        (failure) => SearchDoctorsError(failure.errorMessage),
        (doctors) => SearchDoctorsLoaded(doctors),
      );
    } else {
      final result = await searchDoctorsUseCase(
        SearchDoctorsUseCaseParams(
          query: searchQuery.query,
          specialtyId: searchQuery.specialtyId,
          gender: searchQuery.gender,
          minPrice: searchQuery.minPrice,
          maxPrice: searchQuery.maxPrice,
          hospitalId: searchQuery.hospitalId,
        ),
      );
      yield result.fold(
        (failure) => SearchDoctorsError(failure.errorMessage),
        (doctors) => SearchDoctorsLoaded(doctors),
      );
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    _searchSubject.close();
    return super.close();
  }
}
