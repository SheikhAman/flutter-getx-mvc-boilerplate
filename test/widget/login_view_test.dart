import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/routes/app_routes.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/services/auth_service.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/services/storage_service.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/values/app_strings.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/auth/views/login_view.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/showcase/bindings/showcase_binding.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/showcase/views/showcase_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class _FakeStorageService extends StorageService {
  final Map<String, dynamic> _data = {};
  @override
  T? read<T>(String key, {T? defaultValue}) =>
      (_data[key] as T?) ?? defaultValue;
  @override
  Future<void> write(String key, dynamic value) async => _data[key] = value;
  @override
  bool hasData(String key) => _data.containsKey(key);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.testMode = true;
    final storage = _FakeStorageService();
    Get.put<StorageService>(storage, permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<AuthController>(AuthController());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets(
      'Tapping Explore Component Gallery navigates to ShowcaseView without auth redirect',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        translations: AppStrings(),
        locale: const Locale('en', 'US'),
        initialRoute: AppRoutes.login,
        getPages: [
          GetPage(
            name: AppRoutes.login,
            page: () => LoginView(),
          ),
          GetPage(
            name: AppRoutes.showcase,
            page: () => const ShowcaseView(),
            binding: ShowcaseBinding(),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    // Verify login view is displayed
    expect(find.text('Explore Component Gallery'), findsOneWidget);

    // Tap 'Explore Component Gallery'
    await tester.tap(find.text('Explore Component Gallery'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify user is navigated to ShowcaseView
    expect(find.byType(ShowcaseView), findsOneWidget);
    expect(find.text('Design System & Tokens'), findsOneWidget);
  });
}
