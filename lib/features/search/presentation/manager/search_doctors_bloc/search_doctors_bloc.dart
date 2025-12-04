import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:meta/meta.dart';

part 'search_doctors_event.dart';
part 'search_doctors_state.dart';

class SearchDoctorsBloc extends Bloc<SearchDoctorsEvent, SearchDoctorsState> {
  SearchDoctorsBloc() : super(SearchDoctorsInitial()) {
    on<SearchDoctorsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
