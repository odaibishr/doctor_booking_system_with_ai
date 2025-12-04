import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/search/domain/usecases/search_doctors_use_case.dart';
import 'package:meta/meta.dart';

part 'search_doctors_event.dart';
part 'search_doctors_state.dart';

class SearchDoctorsBloc extends Bloc<SearchDoctorsEvent, SearchDoctorsState> {
  final SearchDoctorsUseCase searchDoctorsUseCase;

  SearchDoctorsBloc(this.searchDoctorsUseCase) : super(SearchDoctorsInitial()) {
    on<SearchDoctorsQueryChanged>((event, emit) {
      onSearchDcotrosQueryChanged(event, emit);
    });
  }

  Future<void> onSearchDcotrosQueryChanged(
    SearchDoctorsQueryChanged event,
    Emitter<SearchDoctorsState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(SearchDoctorsInitial());
      return;
    } else {
      emit(SearchDoctorsLoading());

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
