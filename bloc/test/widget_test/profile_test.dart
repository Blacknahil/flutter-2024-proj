import 'package:bloc_2/application/user/bloc/user_bloc.dart';
import 'package:bloc_2/presentation/profile/profile.dart';
import 'package:bloc_2/presentation/screens/home_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';

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

  // testWidgets(' profile information when logged in',
  //     (WidgetTester tester) async {
  //   // Mock the state to show the profile information of the logged-in admin
  //   whenListen(
  //     mockUserProfileBloc,
  //     Stream.value(const UserProfileState(
  //         name: 'Nahom Garefo',
  //         email: 'admin@example.com',
  //         userId: 'admin1',
  //         loggedIn: true,
  //         banned: false,
  //         folderIds: [],
  //         isProfileFetched: true,
  //         token: 'some_token',
  //         role: 'admin')),
  //     initialState: const UserProfileState(
  //         name: '',
  //         email: '',
  //         userId: '',
  //         loggedIn: false,
  //         banned: false,
  //         folderIds: [],
  //         isProfileFetched: false,
  //         token: '',
  //         role: 'admin'),
  //   );

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: BlocProvider<UserProfileBloc>(
  //         create: (context) => mockUserProfileBloc,
  //         child: ProfilePage(),
  //       ),
  //     ),
  //   );

  //   // Verify the profile information is displayed
  //   expect(find.text('admin@example.com'), findsNothing);
  // });

  // testWidgets('AdminDashboard displays profile information when logged in',
  //     (WidgetTester tester) async {
  //   // Mock the state to show the profile information of the logged-in admin
  //   whenListen(
  //     mockUserProfileBloc,
  //     Stream.value(const UserProfileState(
  //         name: 'Nahom Garefo',
  //         email: 'admin@example.com',
  //         userId: 'admin1',
  //         loggedIn: true,
  //         banned: false,
  //         folderIds: [],
  //         isProfileFetched: true,
  //         token: 'some_token',
  //         role: 'admin')),
  //     initialState: const UserProfileState(
  //         name: '',
  //         email: '',
  //         userId: '',
  //         loggedIn: false,
  //         banned: false,
  //         folderIds: [],
  //         isProfileFetched: false,
  //         token: '',
  //         role: 'admin'),
  //   );

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: BlocProvider<UserProfileBloc>(
  //           create: (context) => mockUserProfileBloc,
  //           child: Scaffold(
  //             body: ProfilePage(),
  //           )),
  //     ),
  //   );

  //   // Verify the profile information is displayed
  //   expect(find.text('Nahom Garefo'), findsOneWidget);
  // });
}
