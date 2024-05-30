import '../domain/core/valid_objects.dart';

void showingTheEmailAddressOrFailure(EmailAddress emailAddress) {
  // Longer to write but we can get the failure instance
  final emailText1 = emailAddress.value.fold(
    (left) => 'Failure happened, more precisely: $left',
    (right) => right,
  );

  // Shorter to write but we cannot get the failure instance
  final emailText2 =
      emailAddress.value.getOrElse(() => 'Some failure happened');
}
