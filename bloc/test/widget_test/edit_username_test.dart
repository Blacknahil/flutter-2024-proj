import 'package:bloc_2/application/user/bloc/user_bloc.dart';
import 'package:bloc_2/presentation/profile/change_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc/bloc.dart';
// Adjust import as per your project structure

class MockUserProfileBloc extends MockBloc<UserProfileEvent, UserProfileState>
    implements UserProfileBloc {}

void main() {
  late MockUserProfileBloc userProfileBloc;

  setUp(() {
    userProfileBloc = MockUserProfileBloc();
  });

  tearDown(() {
    userProfileBloc.close();
  });

//   group('EditUsernameScreen', () {
//     testWidgets('renders UI elements', (WidgetTester tester) async {
//       // Define initial state or expected state of the bloc
//       when(() => userProfileBloc.state).thenReturn(UserProfileInitial());

//       // Build the widget under test
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: BlocProvider.value(
//               value: userProfileBloc,
//               child: edit_username(),
//             ),
//           ),
//         ),
//       );

//       // Verify UI elements are present
//       expect(find.text('Edit Username'), findsOneWidget);
//       expect(find.byType(TextFormField), findsOneWidget);
//       expect(find.text('Save'), findsOneWidget);

//       // Example: Tap on Save button and verify behavior
//       // await tester.tap(find.text('Save'));
//       // await tester.pump();
//       // expect(find.text('Username updated!'), findsOneWidget);
//     });
//   });
}
