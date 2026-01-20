import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:flutter/material.dart';

class CachedDataBuilder<T> extends StatelessWidget {
  final Query<Either<Failure, T>> query;
  final Widget Function(T data) builder;
  final Widget Function()? loadingBuilder;
  final Widget Function(String error)? errorBuilder;

  const CachedDataBuilder({
    super.key,
    required this.query,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return QueryBuilder<Either<Failure, T>>(
      query: query,
      builder: (context, state) {
        if (state.status == QueryStatus.loading && state.data == null) {
          return loadingBuilder?.call() ??
              const Center(child: CircularProgressIndicator());
        }

        if (state.data != null) {
          return state.data!.fold(
            (failure) =>
                errorBuilder?.call(failure.errorMessage) ??
                Center(child: Text(failure.errorMessage)),
            (data) => builder(data),
          );
        }

        if (state.error != null) {
          return errorBuilder?.call(state.error.toString()) ??
              Center(child: Text(state.error.toString()));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
