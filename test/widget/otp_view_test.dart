import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/network/api_constants.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/services/auth_service.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/services/storage_service.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/values/app_strings.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/auth/providers/auth_provider.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/auth/views/otp_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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

  group('OtpView Widget Tests', () {
    testWidgets('renders all OTP elements properly', (tester) async {
      await tester.pumpWidget(buildTestHost(const OtpView()));
      await tester.pump();

      expect(find.byType(PinCodeTextField), findsOneWidget);
      expect(find.text('Demo OTP: ${ApiConstants.demoOtp} (Tap to auto-fill)'),
          findsOneWidget);
      expect(find.text(AppStrings.verify.tr), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('auto-fill button populates OTP controller and fills fields',
        (tester) async {
      await tester.pumpWidget(buildTestHost(const OtpView()));
      await tester.pump();

      final controller = Get.find<AuthController>();
      expect(controller.otpController.text, isEmpty);

      // Tap the auto-fill banner
      await tester.tap(
          find.text('Demo OTP: ${ApiConstants.demoOtp} (Tap to auto-fill)'));
      await tester.pump(const Duration(milliseconds: 350));

      expect(controller.otpController.text, ApiConstants.demoOtp);
      expect(controller.otpCode.value, ApiConstants.demoOtp);

      // Advance mock verify delay and snackbar
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets(
        'tapping verify with empty code shows warning and does not crash',
        (tester) async {
      await tester.pumpWidget(buildTestHost(const OtpView()));
      await tester.pump();

      // Tap Verify & Continue with empty field
      await tester.tap(find.text(AppStrings.verify.tr));
      await tester.pump();

      final controller = Get.find<AuthController>();
      expect(controller.isOtpVerifying.value, isFalse);

      // Drain snackbar animation
      await tester.pump(const Duration(seconds: 5));
    });
  });
}
