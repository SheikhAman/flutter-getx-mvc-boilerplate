import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/utils/app_dialog.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/values/app_colors.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/values/app_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestApp(Widget child) {
    return GetMaterialApp(
      translations: AppStrings(),
      locale: const Locale('en', 'US'),
      home: Scaffold(body: child),
    );
  }

  group('AppDialog Widget Tests', () {
    testWidgets('AppDialog.confirm displays title, message, and actions',
        (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                AppDialog.confirm(
                  title: 'Confirm Action',
                  message: 'Are you sure you want to proceed?',
                  confirmText: 'Yes',
                  cancelText: 'No',
                );
              },
              child: const Text('Open Dialog'),
            ),
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm Action'), findsOneWidget);
      expect(find.text('Are you sure you want to proceed?'), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);

      // Tap Cancel
      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm Action'), findsNothing);
    });

    testWidgets('AppDialog.confirm onConfirm callback is executed',
        (tester) async {
      bool confirmed = false;

      await tester.pumpWidget(
        buildTestApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                AppDialog.confirm(
                  title: 'Delete Item',
                  message: 'This cannot be undone.',
                  isDestructive: true,
                  onConfirm: () {
                    confirmed = true;
                  },
                );
              },
              child: const Text('Delete'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(find.text('Delete Item'), findsOneWidget);

      // Find destructive button and verify styling
      final confirmButtonFinder = find.widgetWithText(ElevatedButton, 'Logout');
      expect(confirmButtonFinder, findsOneWidget);

      final button = tester.widget<ElevatedButton>(confirmButtonFinder);
      final bgColor = button.style?.backgroundColor?.resolve({});
      expect(bgColor, equals(AppColors.error));

      // Tap confirm
      await tester.tap(confirmButtonFinder);
      await tester.pumpAndSettle();

      expect(confirmed, isTrue);
      expect(find.text('Delete Item'), findsNothing);
    });
  });
}
