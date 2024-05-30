import 'package:bloc_2/presentation/log_in/log_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/authentication/sign_in_form/bloc/sign_in_form_bloc.dart';
import '../../domain/auth/authentication_repository.dart';

class LoginPageProvider extends StatelessWidget {
  const LoginPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Log In")),
      body: BlocProvider(
        create: (context) => SignInFormBloc(authenticationRepository),
        child: LogInScreen(),
      ),
    );
  }
}
