import 'package:bloc_2/application/user/bloc/user_bloc.dart';
import 'package:bloc_2/domain/user/user.dart';
import 'package:bloc_2/presentation/admin/admin_dashboard.dart';
import 'package:bloc_2/presentation/admin/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart'; // Add bloc_test package for convenience

class MockUserProfileBloc extends MockBloc<UserProfileEvent, UserProfileState>
    implements UserProfileBloc {}

class FakeUserProfileState extends Fake implements UserProfileState {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;

  setUpAll(() {
    registerFallbackValue(FakeUserProfileState());
  });

  setUp(() {
    mockUserProfileBloc = MockUserProfileBloc();
  });

  tearDown(() {
    mockUserProfileBloc.close();
  });

  testWidgets('AdminDashboard displays profile information when logged in',
      (WidgetTester tester) async {
    // Mock the state to show the profile information of the logged-in admin
    whenListen(
      mockUserProfileBloc,
      Stream.value(const UserProfileState(
          name: 'Admin User',
          email: 'admin@example.com',
          userId: 'admin1',
          loggedIn: true,
          banned: false,
          folderIds: [],
          isProfileFetched: true,
          token: 'some_token',
          role: 'admin')),
      initialState: const UserProfileState(
          name: '',
          email: '',
          userId: '',
          loggedIn: false,
          banned: false,
          folderIds: [],
          isProfileFetched: false,
          token: '',
          role: 'admin'),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: AdminDashboard(),
        ),
      ),
    );

    // Verify the profile information is displayed
    expect(find.text('Admin Dashboard'), findsOneWidget);
  });

  testWidgets('AdminDashboard displays profile information when logged in',
      (WidgetTester tester) async {
    // Mock the state to show the profile information of the logged-in admin
    whenListen(
      mockUserProfileBloc,
      Stream.value(const UserProfileState(
          name: 'Admin User',
          email: 'admin@example.com',
          userId: 'admin1',
          loggedIn: true,
          banned: false,
          folderIds: [],
          isProfileFetched: true,
          token: 'some_token',
          role: 'admin')),
      initialState: const UserProfileState(
          name: '',
          email: '',
          userId: '',
          loggedIn: false,
          banned: false,
          folderIds: [],
          isProfileFetched: false,
          token: '',
          role: 'admin'),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: AdminDashboard(),
        ),
      ),
    );

    // Verify the profile information is displayed
    expect(find.text('Admin Dashboard'), findsOneWidget);
  });

  testWidgets(
      'AdminDashboard shows CircularProgressIndicator when profile is fetching',
      (WidgetTester tester) async {
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
      errorMessage: null,
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: AdminDashboard(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'AdminDashboard displays list of users when UsersLoaded state is emitted',
      (WidgetTester tester) async {
    final users = [
      User(
          name: 'User 1',
          email: 'user1@example.com',
          id: '1',
          banned: true,
          folders: [],
          role: "admin"),
      User(
          name: 'User 2',
          email: 'user2@example.com',
          id: '2',
          folders: [],
          banned: true,
          role: 'user')
    ];

    when(() => mockUserProfileBloc.state).thenReturn(UsersLoaded(
      users: users,
      name: 'Admin User',
      email: 'admin@example.com',
      userId: 'admin1',
      loggedIn: true,
      banned: false,
      folderIds: [],
      isProfileFetched: true,
      token: 'some_token',
      role: 'admin',
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: AdminDashboard(),
        ),
      ),
    );

    expect(find.text('Admin Dashboard'), findsOneWidget);
    expect(find.text('User 1'), findsOneWidget);
    expect(find.text('user1@example.com'), findsOneWidget);
    expect(find.text('User 2'), findsOneWidget);
    expect(find.text('user2@example.com'), findsOneWidget);
  });

  testWidgets(
      'AdminDashboard displays list of users when UsersLoaded state is emitted',
      (WidgetTester tester) async {
    final users = [
      User(
          name: 'User 1',
          email: 'user1@example.com',
          id: '1',
          banned: true,
          folders: [],
          role: "admin"),
      User(
          name: 'User 2',
          email: 'user2@example.com',
          id: '2',
          folders: [],
          banned: true,
          role: 'user')
    ];

    when(() => mockUserProfileBloc.state).thenReturn(UsersLoaded(
      users: users,
      name: 'Admin User',
      email: 'admin@example.com',
      userId: 'admin1',
      loggedIn: true,
      banned: false,
      folderIds: [],
      isProfileFetched: true,
      token: 'some_token',
      role: 'admin',
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: AdminDashboard(),
        ),
      ),
    );

    expect(find.text('User 1'), findsOneWidget);
  });
  testWidgets(
      'AdminDashboard displays list of users when UsersLoaded state is emitted',
      (WidgetTester tester) async {
    final users = [
      User(
          name: 'User 1',
          email: 'user1@example.com',
          id: '1',
          banned: true,
          folders: [],
          role: "admin"),
      User(
          name: 'User 2',
          email: 'user2@example.com',
          id: '2',
          folders: [],
          banned: true,
          role: 'user')
    ];

    when(() => mockUserProfileBloc.state).thenReturn(UsersLoaded(
      users: users,
      name: 'Admin User',
      email: 'admin@example.com',
      userId: 'admin1',
      loggedIn: true,
      banned: false,
      folderIds: [],
      isProfileFetched: true,
      token: 'some_token',
      role: 'admin',
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: AdminDashboard(),
        ),
      ),
    );

    expect(find.text('user1@example.com'), findsOneWidget);
  });

  testWidgets(
      'AdminDashboard displays list of users when UsersLoaded state is emitted',
      (WidgetTester tester) async {
    final users = [
      User(
          name: 'User 1',
          email: 'user1@example.com',
          id: '1',
          banned: true,
          folders: [],
          role: "admin"),
      User(
          name: 'User 2',
          email: 'user2@example.com',
          id: '2',
          folders: [],
          banned: true,
          role: 'user')
    ];

    when(() => mockUserProfileBloc.state).thenReturn(UsersLoaded(
      users: users,
      name: 'Admin User',
      email: 'admin@example.com',
      userId: 'admin1',
      loggedIn: true,
      banned: false,
      folderIds: [],
      isProfileFetched: true,
      token: 'some_token',
      role: 'admin',
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: AdminDashboard(),
        ),
      ),
    );

    expect(find.text('User 2'), findsOneWidget);
  });

  testWidgets(
      'AdminDashboard displays list of users when UsersLoaded state is emitted',
      (WidgetTester tester) async {
    final users = [
      User(
          name: 'User 1',
          email: 'user1@example.com',
          id: '1',
          banned: true,
          folders: [],
          role: "admin"),
      User(
          name: 'User 2',
          email: 'user2@example.com',
          id: '2',
          folders: [],
          banned: true,
          role: 'user')
    ];

    when(() => mockUserProfileBloc.state).thenReturn(UsersLoaded(
      users: users,
      name: 'Admin User',
      email: 'admin@example.com',
      userId: 'admin1',
      loggedIn: true,
      banned: false,
      folderIds: [],
      isProfileFetched: true,
      token: 'some_token',
      role: 'admin',
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: AdminDashboard(),
        ),
      ),
    );

    expect(find.text('user2@example.com'), findsOneWidget);
  });

  testWidgets(
      'AdminDashboard displays list of users when UsersLoaded state is emitted',
      (WidgetTester tester) async {
    final users = [
      User(
          name: 'User 1',
          email: 'user1@example.com',
          id: '1',
          banned: true,
          folders: [],
          role: "admin"),
      User(
          name: 'User 2',
          email: 'user2@example.com',
          id: '2',
          folders: [],
          banned: true,
          role: 'user')
    ];
    final user1 = users[0];

    when(() => mockUserProfileBloc.state).thenReturn(UsersLoaded(
      users: users,
      name: 'Admin User',
      email: 'admin@example.com',
      userId: 'admin1',
      loggedIn: true,
      banned: false,
      folderIds: [],
      isProfileFetched: true,
      token: 'some_token',
      role: 'admin',
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: UserDetailScreen(
            user: user1,
          ),
        ),
      ),
    );

    expect(find.text('Name: User 1'), findsOneWidget);
  });

  testWidgets(
      'AdminDashboard displays list of users when UsersLoaded state is emitted',
      (WidgetTester tester) async {
    final users = [
      User(
          name: 'User 1',
          email: 'user1@example.com',
          id: '1',
          banned: true,
          folders: [],
          role: "admin"),
      User(
          name: 'User 2',
          email: 'user2@example.com',
          id: '2',
          folders: [],
          banned: true,
          role: 'user')
    ];
    final user1 = users[0];

    when(() => mockUserProfileBloc.state).thenReturn(UsersLoaded(
      users: users,
      name: 'Admin User',
      email: 'admin@example.com',
      userId: 'admin1',
      loggedIn: true,
      banned: false,
      folderIds: [],
      isProfileFetched: true,
      token: 'some_token',
      role: 'admin',
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: UserDetailScreen(
            user: user1,
          ),
        ),
      ),
    );

    expect(find.text('User ID: 1'), findsOneWidget);
    expect(find.text('Role: admin'), findsOneWidget);
    expect(find.text('Email: user1@example.com'), findsOneWidget);
    expect(find.text('Folders: 0'), findsOneWidget);
  });

  testWidgets(
      'AdminDashboard displays list of users when UsersLoaded state is emitted',
      (WidgetTester tester) async {
    final users = [
      User(
          name: 'User 1',
          email: 'user1@example.com',
          id: '1',
          banned: true,
          folders: [],
          role: "admin"),
      User(
          name: 'User 2',
          email: 'user2@example.com',
          id: '2',
          folders: [],
          banned: true,
          role: 'user')
    ];
    final user1 = users[0];

    when(() => mockUserProfileBloc.state).thenReturn(UsersLoaded(
      users: users,
      name: 'Admin User',
      email: 'admin@example.com',
      userId: 'admin1',
      loggedIn: true,
      banned: false,
      folderIds: [],
      isProfileFetched: true,
      token: 'some_token',
      role: 'admin',
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserProfileBloc>(
          create: (context) => mockUserProfileBloc,
          child: UserDetailScreen(
            user: user1,
          ),
        ),
      ),
    );

    expect(find.text('Email: user1@example.com'), findsOneWidget);
    expect(find.text('Folders: 0'), findsOneWidget);
  });
}
