/// Result class untuk error handling yang type-safe
/// Mengikuti functional programming principles
sealed class Result<T> {
  const Result();
}

/// Success result dengan data
final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.data == data;
  }
  
  @override
  int get hashCode => data.hashCode;
  
  @override
  String toString() => 'Success(data: $data)';
}

/// Failure result dengan error
final class Failure<T> extends Result<T> {
  final String message;
  final Exception? exception;
  
  const Failure(this.message, [this.exception]);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure<T> && 
           other.message == message && 
           other.exception == exception;
  }
  
  @override
  int get hashCode => Object.hash(message, exception);
  
  @override
  String toString() => 'Failure(message: $message, exception: $exception)';
}

/// Extension methods untuk Result
extension ResultExtension<T> on Result<T> {
  /// Check if result is success
  bool get isSuccess => this is Success<T>;
  
  /// Check if result is failure
  bool get isFailure => this is Failure<T>;
  
  /// Get data if success, null otherwise
  T? get dataOrNull {
    return switch (this) {
      Success<T> success => success.data,
      Failure<T> _ => null,
    };
  }
  
  /// Get error message if failure, null otherwise
  String? get errorOrNull {
    return switch (this) {
      Success<T> _ => null,
      Failure<T> failure => failure.message,
    };
  }
  
  /// Execute callback based on result type
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, Exception? exception) failure,
  }) {
    return switch (this) {
      Success<T> s => success(s.data),
      Failure<T> f => failure(f.message, f.exception),
    };
  }
  
  /// Map success data to another type
  Result<R> map<R>(R Function(T) mapper) {
    return switch (this) {
      Success<T> success => Success(mapper(success.data)),
      Failure<T> failure => Failure(failure.message, failure.exception),
    };
  }
  
  /// FlatMap for chaining operations
  Result<R> flatMap<R>(Result<R> Function(T) mapper) {
    return switch (this) {
      Success<T> success => mapper(success.data),
      Failure<T> failure => Failure(failure.message, failure.exception),
    };
  }
}