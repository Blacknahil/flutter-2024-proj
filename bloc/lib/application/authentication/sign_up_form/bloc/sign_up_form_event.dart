part of 'sign_up_form_bloc.dart';

abstract class SignUpFormEvent extends Equatable {
  const SignUpFormEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SignUpFormEvent {
  final String emailStr;

  const EmailChanged(this.emailStr);

  @override
  List<Object> get props => [emailStr];
}

class PasswordChanged extends SignUpFormEvent {
  final String passwordStr;

  const PasswordChanged(this.passwordStr);

  @override
  List<Object> get props => [passwordStr];
}

class FirstNameChanged extends SignUpFormEvent {
  final String firstNameStr;

  const FirstNameChanged(this.firstNameStr);

  @override
  List<Object> get props => [firstNameStr];
}

class LastNameChanged extends SignUpFormEvent {
  final String lastNameStr;

  const LastNameChanged(this.lastNameStr);

  @override
  List<Object> get props => [lastNameStr];
}

class RegisterWithEmailAndPasswordPressed extends SignUpFormEvent {
  const RegisterWithEmailAndPasswordPressed();
}
