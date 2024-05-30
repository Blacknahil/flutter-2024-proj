import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/core/auth_failure.dart';
import '../../../../domain/auth/authentication_repository.dart';
import '../../../../domain/core/valid_objects.dart';
import 'dart:developer' as devtools;

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  final AuthenticationRepository _authenticationRepository;

  SignUpFormBloc(this._authenticationRepository)
      : super(SignUpFormState.initial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<RegisterWithEmailAndPasswordPressed>(
        _onRegisterWithEmailAndPasswordPressed);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      emailAddress: EmailAddress(event.emailStr),
      authFailureOrSuccessOption: none(),
    ));
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      password: Password(event.passwordStr),
      authFailureOrSuccessOption: none(),
    ));
  }

  void _onFirstNameChanged(
      FirstNameChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      firstName: FirstName(event.firstNameStr),
      authFailureOrSuccessOption: none(),
    ));
  }

  void _onLastNameChanged(
      LastNameChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      lastName: event.lastNameStr,
      authFailureOrSuccessOption: none(),
    ));
  }

  Future<void> _onRegisterWithEmailAndPasswordPressed(
    RegisterWithEmailAndPasswordPressed event,
    Emitter<SignUpFormState> emit,
  ) async {
    //check by logging
    devtools.log(state.lastName);
    devtools.log(state.firstName.getOrCrash());
    devtools.log(state.emailAddress.getOrCrash());
    devtools.log(state.password.getOrCrash());
    //check by logging
    Either<AuthFailure, Unit> failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    final isFirstNameValid = state.firstName.isValid();

    if (isEmailValid && isPasswordValid && isFirstNameValid) {
      emit(state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ));

      failureOrSuccess = await _authenticationRepository.register(
        state.emailAddress.getOrCrash(),
        state.password.getOrCrash(),
        state.firstName.getOrCrash(),
        state.lastName,
      );
    } else {
      failureOrSuccess =
          left(const AuthFailure.invalidEmailAndPasswordCombination());
    }

    emit(state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    ));
  }
}
