import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/services/auth_service.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/services/storage_service.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/values/app_strings.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/auth/providers/auth_provider.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/auth/views/forgot_password_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class FakeStorageService extends StorageService {
  final Map<String, dynamic> _memory = {};
  @override
  T? read<T>(String key, {T? defaultValue}) =>
      (_memory[key] as T?) ?? defaultValue;
  @override
  Future<void> write(String key, dynamic value) async => _memory[key] = value;
  @override
  bool get isDarkMode => false;
}

void main() {
  setUp(() {
    Get.testMode = true;
    final storage = FakeStorageService();
    Get.put<StorageService>(storage);
    Get.put<AuthService>(AuthService());
    Get.put<AuthController>(AuthController(authProvider: AuthProvider()));
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestHost(Widget child) {
    return GetMaterialApp(
      translations: AppStrings(),
      locale: const Locale('en', 'US'),
      home: child,
    );
  }

  group('ForgotPasswordView Widget Tests', () {
    testWidgets(
        'renders forgot password screen cleanly without duplicate headers',
        (tester) async {
      await tester.pumpWidget(buildTestHost(ForgotPasswordView()));
      await tester.pump();

      // Heading appears once
      expect(find.text('Reset Password'), findsOneWidget);
      // No duplicate Forgot Password in AppBar
      expect(find.text('Forgot Password?'), findsNothing);
    });
  });
}
