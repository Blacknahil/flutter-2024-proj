part of 'sign_in_form_bloc.dart';

class SignInFormState extends Equatable {
  final EmailAddress emailAddress;
  final Password password;
  final bool isSubmitting;
  final bool showErrorMessages;
  final Option<Either<AuthFailure, Tuple2<String, String>>>
      authFailureOrSuccessOption;

  const SignInFormState({
    required this.emailAddress,
    required this.password,
    required this.isSubmitting,
    required this.showErrorMessages,
    required this.authFailureOrSuccessOption,
  });

  factory SignInFormState.initial() {
    return SignInFormState(
      emailAddress: EmailAddress(''),
      password: Password(''),
      isSubmitting: false,
      showErrorMessages: false,
      authFailureOrSuccessOption: none(),
    );
  }

  SignInFormState copyWith({
    EmailAddress? emailAddress,
    Password? password,
    bool? isSubmitting,
    bool? showErrorMessages,
    Option<Either<AuthFailure, Tuple2<String, String>>>?
        authFailureOrSuccessOption,
  }) {
    return SignInFormState(
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      authFailureOrSuccessOption:
          authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
    );
  }

  @override
  List<Object> get props => [
        emailAddress,
        password,
        isSubmitting,
        showErrorMessages,
        authFailureOrSuccessOption,
      ];
}
