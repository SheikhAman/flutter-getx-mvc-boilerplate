import 'package:flutter/services.dart';
import 'package:flutter_core/app/core/routes/app_routes.dart';
import 'package:flutter_core/app/core/services/auth_service.dart';
import 'package:flutter_core/app/core/services/locale_service.dart';
import 'package:flutter_core/app/core/services/storage_service.dart';
import 'package:flutter_core/app/core/services/theme_controller.dart';
import 'package:flutter_core/app/modules/onboarding/views/onboarding_view.dart';
import 'package:flutter_core/app/modules/splash/views/splash_view.dart';
import 'package:flutter_core/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class TestStorageService extends StorageService {
  final Map<String, dynamic> _memory = {};

  @override
  T? read<T>(String key, {T? defaultValue}) {
    return (_memory[key] as T?) ?? defaultValue;
  }

  @override
  Future<void> write(String key, dynamic value) async {
    _memory[key] = value;
  }

  @override
  bool hasData(String key) => _memory.containsKey(key);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async => '.');

  setUp(() {
    Get.testMode = true;
    final storage = TestStorageService();
    Get.put<StorageService>(storage, permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<LocaleService>(LocaleService(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets(
      'App boots on SplashView and navigates to Onboarding with zero white screens',
      (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterCoreApp());

    // Verify initial render is SplashView with app name and logo
    expect(find.byType(SplashView), findsOneWidget);
    expect(find.text('Flutter Core'), findsOneWidget);

    // Advance 2-second timer on splash
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify clean transition to OnboardingView without white screen or exception
    expect(find.byType(OnboardingView), findsOneWidget);
  });
}
