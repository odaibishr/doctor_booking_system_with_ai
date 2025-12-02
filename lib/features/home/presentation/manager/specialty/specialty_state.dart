part of 'specialty_cubit.dart';

@immutable
sealed class SpecialtyState {}

final class SpecialtyInitial extends SpecialtyState {}

final class SpcialtyLoading extends SpecialtyState {}

final class SpecialtyLoaded extends SpecialtyState {
  final List<Specialty> specialties;
  SpecialtyLoaded({required this.specialties});
}

final class SpecialtyError extends SpecialtyState {
  final String message;
  SpecialtyError({required this.message});
}
