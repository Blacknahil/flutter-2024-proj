import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/core/auth_failure.dart';
import '../../../../domain/auth/authentication_repository.dart';
import '../../../../domain/core/valid_objects.dart';
import 'dart:developer' as devtools;

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final AuthenticationRepository _authenticationRepository;

  SignInFormBloc(this._authenticationRepository)
      : super(SignInFormState.initial()) {
    // Register event handlers
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignInWithEmailAndPasswordPressed>(_onSignInWithEmailAndPasswordPressed);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignInFormState> emit) {
    emit(state.copyWith(
      emailAddress: EmailAddress(event.emailStr),
      authFailureOrSuccessOption: none(),
    ));
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<SignInFormState> emit) {
    emit(state.copyWith(
      password: Password(event.passwordStr),
      authFailureOrSuccessOption: none(),
    ));
  }

  Future<void> _onSignInWithEmailAndPasswordPressed(
      SignInWithEmailAndPasswordPressed event,
      Emitter<SignInFormState> emit) async {
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      emit(state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption:
            none(), // Reset to None before login attempt
      ));
      // devtools.log('$state.emailAddress.getOrCrash()');

      final failureOrSuccess = await _authenticationRepository.logIn(
        email: state.emailAddress.getOrCrash(),
        password: state.password.getOrCrash(),
      );
      devtools.log("$failureOrSuccess is the failure or success");

      emit(state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          authFailureOrSuccessOption: optionOf(failureOrSuccess)));
    } else {
      // If email or password is invalid, don't attempt login, set to None
      emit(state.copyWith(
        showErrorMessages: true,
        authFailureOrSuccessOption: none(),
      ));
    }
  }

  // Future<void> _onSignInWithGooglePressed(
  //     SignInWithGooglePressed event, Emitter<SignInFormState> emit) async {
  //   emit(state.copyWith(
  //     isSubmitting: true,
  //     authFailureOrSuccessOption: none(),
  //   ));

  //   final failureOrSuccess = await _authenticationRepository.signInWithGoogle();

  //   emit(state.copyWith(
  //     isSubmitting: false,
  //     authFailureOrSuccessOption: optionOf(failureOrSuccess),
  //   ));
}
