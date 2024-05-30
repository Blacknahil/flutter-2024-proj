import 'package:bloc_2/application/authentication/authentication_bloc.dart';
import 'package:bloc_2/application/folder/bloc/folder_bloc.dart';
import 'package:bloc_2/application/user/bloc/user_bloc.dart';
import 'package:bloc_2/domain/folder/folder_repository.dart';
import 'package:bloc_2/infrastructure/authentication/auth_repository_impl.dart';
import 'package:bloc_2/infrastructure/folders/folders_repository_impl.dart';
import 'package:bloc_2/infrastructure/user/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'app_router.dart';
import 'application/note/bloc/note_bloc.dart';
import 'domain/auth/authentication_repository.dart';
import 'domain/note/note_repository.dart';
import 'domain/user/user_repository.dart';
import 'infrastructure/note/note_repository_impl.dart';
import 'presentation/widgets/loading_animations.dart';

void main() {
  final userRepository = UserRepositoryImpl(httpClient: http.Client());

  final userProfileBloc = UserProfileBloc(userRepository: userRepository);

  final authenticationRepository = AuthRepositoryImpl(
    userProfileBloc: userProfileBloc,
    userRepository: userRepository,
  );
  final foldersRepository = FoldersRepositoryImpl(http.Client());
  final notesRepository = NoteRepositoryImpl(http.Client());

  runApp(
    MyApp(
      authenticationRepository: authenticationRepository,
      userRepository: userRepository,
      foldersRepository: foldersRepository,
      notesRepository: notesRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final FoldersRepository foldersRepository;
  final NoteRepository notesRepository;

  const MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
    required this.foldersRepository,
    required this.notesRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: authenticationRepository)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
                authenticationRepository: authenticationRepository)
              ..add(AuthenticationStarted()),
          ),
          BlocProvider(
            create: (context) =>
                UserProfileBloc(userRepository: userRepository),
          ),
          BlocProvider(create: (context) => FoldersBloc(foldersRepository)),
          BlocProvider(create: (context) => NoteBloc(notesRepository))
        ],
        child: MaterialApp.router(
          title: "NOTES",
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          routerConfig: router, // Use the router configuration
        ),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateBasedOnAuthStatus();
    });
  }

  _navigateBasedOnAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    final authState = context.read<AuthenticationBloc>().state;

    if (authState.status == AuthenticationStatus.authenticated) {
      context.go('/home');
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 23, 40, 55),
      ),
    );

    return const Scaffold(
      body: LoadingAnimation(),
    );
  }
}
