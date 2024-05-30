part of 'sign_up_form_bloc.dart';

class SignUpFormState {
  final EmailAddress emailAddress;
  final Password password;
  final FirstName firstName;
  final String lastName;
  final bool isSubmitting;
  final bool showErrorMessages;
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption;

  const SignUpFormState({
    required this.emailAddress,
    required this.password,
    required this.firstName,
    this.lastName = '',
    required this.isSubmitting,
    required this.showErrorMessages,
    required this.authFailureOrSuccessOption,
  });

  factory SignUpFormState.initial() {
    return SignUpFormState(
      emailAddress: EmailAddress(''),
      password: Password(''),
      firstName: FirstName(''),
      lastName: '',
      isSubmitting: false,
      showErrorMessages: false,
      authFailureOrSuccessOption: none(),
    );
  }

  SignUpFormState copyWith({
    EmailAddress? emailAddress,
    Password? password,
    FirstName? firstName,
    String? lastName,
    bool? isSubmitting,
    bool? showErrorMessages,
    Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption,
  }) {
    return SignUpFormState(
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      authFailureOrSuccessOption:
          authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
    );
  }
}
