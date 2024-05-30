import 'package:bloc_2/domain/core/errors.dart';
import 'package:dartz/dartz.dart';
import 'failures.dart';

abstract class ValueObject<T> {
  Either<ValueFailure<T>, T> get value;

  /// Checks if the value is valid
  bool isValid() => value.isRight();

  /// Returns the value or throws [UnexpectedValueError] if the value is invalid
  T getOrCrash() {
    return value.fold((f) => throw UnexpectedValueError(f), id);
  }

  const ValueObject();
}
