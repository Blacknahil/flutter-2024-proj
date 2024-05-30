import 'package:bloc_2/application/authentication/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:bloc_2/application/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as devtools;

import '../../app_router.dart';
import '../widgets/black_button.dart';
import '../widgets/login_button.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<SignInFormBloc, SignInFormState>(

    return MultiBlocListener(
        listeners: [
          BlocListener<SignInFormBloc, SignInFormState>(
            listener: (context, state) {
              state.authFailureOrSuccessOption.fold(
                () {},
                (either) {
                  either.fold(
                    (failure) {
                      // Authentication failed, handle the failure
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(failure.map(
                            invalidPassword: (_) => "Invalid password",
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
                    (credentials) {
                      // Authentication succeeded, fetch user profile
                      context.read<UserProfileBloc>().add(FetchUserProfile(
                          credentials.value1, credentials.value2));
                      // router.go('/adminDashboard');
                    },
                  );
                },
              );
            },
          ),
          BlocListener<UserProfileBloc, UserProfileState>(
            listener: (context, userState) {
              if (userState.isProfileFetched) {
                if (userState.role == 'admin') {
                  context
                      .read<UserProfileBloc>()
                      .add(FetchAllUsers(userState.token));
                  router.go('/adminDashboard');
                } else {
                  router.go('/home');
                }
              }
            },
          ),
        ],
        child: BlocBuilder<SignInFormBloc, SignInFormState>(
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
                        const SizedBox(height: 40),
                        const Text(
                          "Welcome!",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Please enter your details to continue",
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 7),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                            ),
                            onChanged: (value) => context
                                .read<SignInFormBloc>()
                                .add(EmailChanged(value)),
                            validator: (_) => state.emailAddress.value.fold(
                              (f) => f.maybeMap(
                                invalidEmail: (_) => 'Invalid Email',
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 7),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !showPassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              suffixIcon: InkWell(
                                onTap: () {
                                  // Handle show/hide password logic
                                },
                                child: showPassword
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                            ),
                            onChanged: (value) => context
                                .read<SignInFormBloc>()
                                .add(PasswordChanged(value)),
                            validator: (_) => state.password.value.fold(
                              (f) => f.maybeMap(
                                shortPassword: (_) => 'Short Password',
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                          ),
                        ),
                        BlackButton(
                          text: "Log in",
                          onPressed: () {
                            devtools.log(
                                "Log in button pressed"); // Log button press
                            context.read<SignInFormBloc>().add(
                                  const SignInWithEmailAndPasswordPressed(),
                                );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "OR",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        LogInButton(
                          imageUrl: 'assets/images/google.png',
                          signInMethod: "Google",
                          onPressed: () {
                            // Handle Google sign-in
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/register');
                            devtools.log("Go to sign up screen clicked");
                          },
                          child: RichText(
                            text: const TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  text: "Sign up for free",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/home');
                          },
                          child: RichText(
                            text: const TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "Don't Want to sign up? Continue to use"),
                                TextSpan(
                                  text: " Your Notes App.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 73, 147, 208)),
                                ),
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
        ));
  }
}
