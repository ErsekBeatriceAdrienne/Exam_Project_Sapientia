import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_dsa/main.dart';

void main()
{
  testWidgets('Registration form validation', (WidgetTester tester) async {
    // Build your widget
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Find the TextField by key
    final firstNameField = find.byKey(Key('firstNameField'));

    // Check if the TextField is present
    expect(firstNameField, findsOneWidget);

    // Simulate entering text into the TextField
    await tester.enterText(firstNameField, 'John');

    // Rebuild the widget
    await tester.pump();

  });
}
