import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../application/authentication/sign_up_form/bloc/sign_up_form_bloc.dart';
import '../screens/home_page.dart';
import '../log_in/log_in_form.dart';
import 'dart:developer' as devtools;

class SignUpAppForm extends StatelessWidget {
  SignUpAppForm({Key? key}) : super(key: key);

  final showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) {
            either.fold(
              (failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(failure.map(
                      invalidPassword: (_) => "Invalid Password",
                      cancelledByUser: (_) => 'Cancelled',
                      serverError: (_) => 'Server Error',
                      emailAlreadyInUse: (_) => 'Email already in use',
                      invalidEmailAndPasswordCombination: (_) =>
                          'Invalid email and password combination',
                      jsonException: (_) => 'JSON Exception',
                    )),
                  ),
                );
              },
              (_) {
                context.go('/home');
              },
            );
          },
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Sign up',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please enter your details to create an account',
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 7),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First name',
                        ),
                        onChanged: (value) => context
                            .read<SignUpFormBloc>()
                            .add(FirstNameChanged(value)),
                        validator: (_) => context
                            .read<SignUpFormBloc>()
                            .state
                            .firstName
                            .value
                            .fold(
                              (f) => f.maybeMap(
                                emptyFirstName: (_) =>
                                    'Please enter your first name',
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 7),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last name',
                        ),
                        onChanged: (value) => context
                            .read<SignUpFormBloc>()
                            .add(LastNameChanged(value)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 7),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Email'),
                        onChanged: (value) => context
                            .read<SignUpFormBloc>()
                            .add(EmailChanged(value)),
                        validator: (_) => context
                            .read<SignUpFormBloc>()
                            .state
                            .emailAddress
                            .value
                            .fold(
                              (f) => f.maybeMap(
                                invalidEmail: (_) => 'Invalid Email',
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                      ),
                    ),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 7),
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !showPassword,
                        onChanged: (value) => context
                            .read<SignUpFormBloc>()
                            .add(PasswordChanged(value)),
                        validator: (_) => context
                            .read<SignUpFormBloc>()
                            .state
                            .password
                            .value
                            .fold(
                              (f) => f.maybeMap(
                                shortPassword: (_) => 'Short Password',
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          suffixIcon: InkWell(
                            onTap: () {
                              // setState(() {
                              //   showPassword = !showPassword;
                              // });
                            },
                            child: showPassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 60,
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 30, vertical: 7),
                    //   margin: const EdgeInsets.only(bottom: 30),
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(20)),
                    //   child: TextFormField(
                    //     obscureText: !showPassword,
                    //     validator: (value) {
                    //       if (value != null) {
                    //         if (value.isEmpty) {
                    //           return 'Please confirm your password';
                    //         }
                    //       }
                    //       return null;
                    //     },
                    //     decoration: InputDecoration(
                    //       suffixIcon: InkWell(
                    //         onTap: () {
                    //           // // setState(() {
                    //           // //   showPassword = !showPassword;
                    //           // });
                    //         },
                    //         child: showPassword
                    //             ? const Icon(Icons.visibility_off)
                    //             : const Icon(Icons.visibility),
                    //       ),
                    //       border: InputBorder.none,
                    //       hintText: 'Confirm password',
                    //     ),
                    //   ),
                    // ),
                    TextButton(
                      child: const Text('Register'),
                      //add a background color

                      onPressed: () {
                        context
                            .read<SignUpFormBloc>()
                            .add(const RegisterWithEmailAndPasswordPressed());
                        // devtools.log(state.lastName);
                        // devtools.log(state.firstName.getOrCrash());
                        // devtools.log(state.emailAddress.getOrCrash());
                        // devtools.log(state.password.getOrCrash());
                      },
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Already have an account? ',
                            ),
                            TextSpan(
                                text: 'Log in',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
