part of 'sign_in_form_bloc.dart';

abstract class SignInFormEvent extends Equatable {
  const SignInFormEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SignInFormEvent {
  final String emailStr;

  const EmailChanged(this.emailStr);

  @override
  List<Object> get props => [emailStr];
}

class PasswordChanged extends SignInFormEvent {
  final String passwordStr;

  const PasswordChanged(this.passwordStr);

  @override
  List<Object> get props => [passwordStr];
}

class SignInWithEmailAndPasswordPressed extends SignInFormEvent {
  const SignInWithEmailAndPasswordPressed();
}

class SignInWithGooglePressed extends SignInFormEvent {
  const SignInWithGooglePressed();
}
