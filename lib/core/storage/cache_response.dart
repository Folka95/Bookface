enum CacheResponseState {
  ok,
  expired,
  invalid,
  error,
}

class CacheResponse<T> {
  final CacheResponseState state;
  final T? cached;
  final String? error;

  const CacheResponse({
    required this.state,
    this.cached,
    this.error,
  });

  bool get isOk => state == CacheResponseState.ok;
  bool get isExpired => state == CacheResponseState.expired;
  bool get isInvalid => state == CacheResponseState.invalid;
  bool get isError => state == CacheResponseState.error;
}