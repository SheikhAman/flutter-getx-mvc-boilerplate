import 'package:flutter/material.dart';
import 'package:flutter_core/app/core/widgets/custom_button.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  group('CustomButton Widget Tests', () {
    testWidgets('renders button text correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const CustomButton(text: 'Click Me'),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('triggers onPressed callback when tapped',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        buildTestableWidget(
          CustomButton(
            text: 'Submit',
            onPressed: () {
              tapped = true;
            },
          ),
        ),
      );

      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('displays CircularProgressIndicator when isLoading is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const CustomButton(
            text: 'Loading...',
            isLoading: true,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsNothing);
    });

    testWidgets('renders leading icon when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const CustomButton(
            text: 'Favorite',
            icon: Icons.favorite,
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.text('Favorite'), findsOneWidget);
    });
  });
}
