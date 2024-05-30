import 'package:dartz/dartz.dart';
import 'failures.dart';
import 'value_objects.dart';
import 'value_validators.dart';

class EmailAddress extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(
    this.value,
  );
}

class Password extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(
    this.value,
  );
}

void showingTheEmailAddressOrFailure() {
  final emailAddress = EmailAddress("fafsfs");

  String emailText1 = emailAddress.value
      .fold((left) => "Failure happend: $left", (right) => right);

  String emiailText2 =
      emailAddress.value.getOrElse(() => "Some failure happend");
}

class FirstName extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  factory FirstName(String input) {
    assert(input != null);
    return FirstName._(
      validateFirstName(input),
    );
  }

  const FirstName._(this.value);
}
