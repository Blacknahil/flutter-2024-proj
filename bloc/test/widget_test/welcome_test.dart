// test/widget_test/welcome_screen_test.dart
// Adjust the import as necessary
import 'package:bloc_2/presentation/log_in/log_in_form.dart';
import 'package:bloc_2/presentation/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('WelcomeScreen Widget Tests', () {
    testWidgets('WelcomeScreen displays welcome image',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WelcomeScreen(),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.image(const AssetImage('assets/images/Welcome.png')),
          findsOneWidget);
    });

    testWidgets('WelcomeScreen displays welcome text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WelcomeScreen(),
        ),
      );

      expect(find.text('Capture Your Moments. \n Pen Your Journey.'),
          findsOneWidget);
    });

    testWidgets('WelcomeScreen has an arrow button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WelcomeScreen(),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);
    });
  });
  testWidgets('WelcomeScreen displays welcome image',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeScreen(),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    expect(find.image(const AssetImage('assets/images/Welcome.png')),
        findsOneWidget);
  });

  testWidgets('WelcomeScreen displays welcome image',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeScreen(),
      ),
    );
    expect(find.image(const AssetImage('assets/images/Welcome.png')),
        findsOneWidget);
  });
}
