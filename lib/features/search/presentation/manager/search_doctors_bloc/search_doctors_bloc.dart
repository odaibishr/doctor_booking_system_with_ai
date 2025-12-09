import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/search/domain/usecases/search_doctors_use_case.dart';
import 'package:meta/meta.dart';

part 'search_doctors_event.dart';
part 'search_doctors_state.dart';

class SearchDoctorsBloc extends Bloc<SearchDoctorsEvent, SearchDoctorsState> {
  final SearchDoctorsUseCase searchDoctorsUseCase;
  final GetDoctorsUseCase getDoctorsUseCase;

  SearchDoctorsBloc(this.searchDoctorsUseCase, this.getDoctorsUseCase)
    : super(SearchDoctorsInitial())  {
    on<SearchDoctorsQueryChanged>((event, emit) async {
      await onSearchDoctorsQueryChanged(event, emit);
    });
  }

  Future<void> onSearchDoctorsQueryChanged(
    SearchDoctorsQueryChanged event,
    Emitter<SearchDoctorsState> emit,
  ) async {
    emit(SearchDoctorsLoading());
    if (event.query.trim().isEmpty) {
      final result = await getDoctorsUseCase(NoParams());

      result.fold(
        (failure) => emit(SearchDoctorsError(failure.errorMessage)),
        (doctors) => emit(SearchDoctorsLoaded(doctors)),
      );
    } else {
      final result = await searchDoctorsUseCase(
        SearchDoctorsUseCaseParams(event.query),
      );

      result.fold(
        (failure) => emit(SearchDoctorsError(failure.errorMessage)),
        (doctors) => emit(SearchDoctorsLoaded(doctors)),
      );
    }
  }
}
