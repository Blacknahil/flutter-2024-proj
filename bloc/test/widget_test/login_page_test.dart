import 'package:bloc_2/application/authentication/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:bloc_2/application/user/bloc/user_bloc.dart';
import 'package:bloc_2/presentation/log_in/log_in_form.dart';
import 'package:bloc_2/presentation/widgets/black_button.dart';
import 'package:bloc_2/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart'; // Adjust the import as necessary
import 'package:bloc_test/bloc_test.dart'; // For mocking Blocs
import 'package:flutter_bloc/flutter_bloc.dart'; // For providing Blocs
import 'package:mocktail/mocktail.dart'; // For mocking dependencies

// Mocking the Blocs
class MockSignInFormBloc extends MockBloc<SignInFormEvent, SignInFormState>
    implements SignInFormBloc {}

class MockUserProfileBloc extends MockBloc<UserProfileEvent, UserProfileState>
    implements UserProfileBloc {}

// Fake classes for event and state
class FakeSignInFormEvent extends Fake implements SignInFormEvent {}

class FakeSignInFormState extends Fake implements SignInFormState {}

class FakeUserProfileEvent extends Fake implements UserProfileEvent {}

class FakeUserProfileState extends Fake implements UserProfileState {}

void main() {
  late MockSignInFormBloc mockSignInFormBloc;
  late MockUserProfileBloc mockUserProfileBloc;

  setUpAll(() {
    // Registering fake classes for fallback values
    registerFallbackValue(FakeSignInFormEvent());
    registerFallbackValue(FakeSignInFormState());
    registerFallbackValue(FakeUserProfileEvent());
    registerFallbackValue(FakeUserProfileState());
  });

  setUp(() {
    mockSignInFormBloc = MockSignInFormBloc();
    mockUserProfileBloc = MockUserProfileBloc();

    // Set up the initial states for the mocked Blocs
    when(() => mockSignInFormBloc.state).thenReturn(SignInFormState.initial());
    when(() => mockUserProfileBloc.state).thenReturn(UserProfileState(
      name: '',
      email: '',
      userId: '',
      loggedIn: false,
      banned: false,
      folderIds: [],
      isProfileFetched: false,
      token: '',
      role: '',
    ));
  });

  testWidgets('LogInScreen UI password and Welcome text test',
      (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    // Verify the presence of text elements
    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('LogInScreen UI Text form test', (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    // Verify the presence of text elements

    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('LogInScreen UI: Enter your details',
      (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    // Verify the presence of text elements
    expect(find.text('Please enter your details to continue'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('LogInScreen UI: Login Or', (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('OR'), findsOneWidget);

    // Verify the presence of text elements
  });

  testWidgets('LogInScreen UI elements: custom button ',
      (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    expect(find.byType(BlackButton),
        findsOneWidget); // Custom BlackButton for Log in
    expect(find.byType(LogInButton), findsOneWidget);

    // Verify the presence of text elements
  });

  testWidgets('LogInScreen UI: Password visibility test',
      (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    expect(find.byIcon(Icons.visibility), findsOneWidget);

    // Verify the presence of text elements
  });

  testWidgets('LogInScreen UI elements test', (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('OR'), findsOneWidget);

    // Verify the presence of text elements
  });

  testWidgets('LogInScreen UI elements test', (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('OR'), findsOneWidget);

    // Verify the presence of text elements
  });

  testWidgets('LogInScreen UI elements test', (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('OR'), findsOneWidget);

    // Verify the presence of text elements
  });

  testWidgets('LogInScreen UI elements test', (WidgetTester tester) async {
    // Providing the mocked Blocs
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SignInFormBloc>(
            create: (context) => mockSignInFormBloc,
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => mockUserProfileBloc,
          ),
        ],
        child: MaterialApp(home: Scaffold(body: LogInScreen())),
      ),
    );

    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('OR'), findsOneWidget);

    // Verify the presence of text elements
  });
}
