import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Combines several [AsyncValue]s: an error wins, then loading, then [build].
AsyncValue<R> combineAsync<R>(
  List<AsyncValue<Object?>> values,
  R Function() build,
) {
  for (final v in values) {
    if (v.hasError && !v.hasValue) {
      return AsyncError<R>(v.error!, v.stackTrace ?? StackTrace.current);
    }
  }
  if (values.any((v) => !v.hasValue)) return AsyncLoading<R>();
  try {
    return AsyncData<R>(build());
  } catch (error, stack) {
    return AsyncError<R>(error, stack);
  }
}
