import 'package:flutter/material.dart';
import 'package:flutter_core/app/core/widgets/custom_text_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }

  group('CustomTextField Widget Tests', () {
    testWidgets('renders label and hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const CustomTextField(
            label: 'Email Address',
            hint: 'user@example.com',
          ),
        ),
      );

      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('user@example.com'), findsOneWidget);
    });

    testWidgets('calls onChanged when user inputs text',
        (WidgetTester tester) async {
      String changedValue = '';
      final controller = TextEditingController();

      await tester.pumpWidget(
        buildTestableWidget(
          CustomTextField(
            controller: controller,
            hint: 'Search...',
            onChanged: (val) {
              changedValue = val;
            },
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello Flutter');
      expect(changedValue, 'Hello Flutter');
      expect(controller.text, 'Hello Flutter');
    });

    testWidgets(
        'toggles obscureText visibility when password eye icon is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const CustomTextField(
            label: 'Password',
            isPassword: true,
          ),
        ),
      );

      // Initially password eye icon is visibility_off_outlined because password is obscured
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

      // Tap to reveal password
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pump();

      // Now icon toggles to visibility_outlined
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });

    testWidgets('renders prefix icon when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const CustomTextField(
            prefixIcon: Icon(Icons.person),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
}
