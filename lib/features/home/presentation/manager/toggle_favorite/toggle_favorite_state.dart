part of 'toggle_favorite_cubit.dart';

@immutable
sealed class ToggleFavoriteState {}

final class ToggleFavoriteInitial extends ToggleFavoriteState {}

final class ToggleFavoriteLoading extends ToggleFavoriteState {}

final class ToggleFavoriteSuccess extends ToggleFavoriteState {}

final class ToggleFavoriteError extends ToggleFavoriteState {}
