part of 'search_doctors_bloc.dart';

sealed class SearchDoctorsEvent {}

final class SearchDoctorsQueryChanged extends SearchDoctorsEvent {
  final String query;
  final int? specialtyId;
  SearchDoctorsQueryChanged({this.query = "", this.specialtyId});
}
