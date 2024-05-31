import 'package:flutter/material.dart';
import 'package:notes_app/domain/core/failures.dart';
import 'package:dartz/dartz.dart';

@immutable
class EmailAddress extends ValueObject<String> {
  @override
  // Add this line

  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}
