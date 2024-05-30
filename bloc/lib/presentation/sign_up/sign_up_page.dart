import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/authentication/sign_up_form/bloc/sign_up_form_bloc.dart';
import '../../domain/auth/authentication_repository.dart';
import 'sign_up_form.dart'; // Adjust the import path as needed

class SignUpAppProvider extends StatelessWidget {
  const SignUpAppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    return Scaffold(
      // appBar: AppBar(title: const Text("Sign Up")),
      body: BlocProvider(
        create: (context) => SignUpFormBloc(authenticationRepository),
        child: SignUpAppForm(),
      ),
    );
  }
}
