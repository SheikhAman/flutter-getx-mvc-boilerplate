import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/app/core/network/api_constants.dart';
import 'package:flutter_core/app/core/routes/app_routes.dart';
import 'package:flutter_core/app/core/services/auth_service.dart';
import 'package:flutter_core/app/core/services/storage_service.dart';
import 'package:flutter_core/app/data/models/user_model.dart';
import 'package:flutter_core/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter_core/app/modules/auth/providers/auth_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class FakeStorageService extends StorageService {
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
  Future<void> remove(String key) async {
    _memory.remove(key);
  }

  @override
  bool hasData(String key) => _memory.containsKey(key);

  @override
  Future<void> clearAll() async => _memory.clear();
}

class MockAuthProvider extends AuthProvider {
  final UserModel mockUser;
  final bool shouldThrow;

  MockAuthProvider({
    this.mockUser = const UserModel(
      id: 'mock_1',
      name: 'John Doe',
      email: 'john@example.com',
      phone: '+1234567890',
    ),
    this.shouldThrow = false,
  });

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    if (shouldThrow) throw Exception('Invalid credentials');
    return mockUser;
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (shouldThrow) throw Exception('Registration failed');
    return mockUser;
  }

  @override
  Future<bool> verifyOtp({required String code, required String email}) async {
    if (shouldThrow) throw Exception('Invalid OTP');
    return code == ApiConstants.demoOtp;
  }

  @override
  Future<bool> sendPasswordReset({required String email}) async {
    if (shouldThrow) throw Exception('Email not found');
    return true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async => '.');

  setUp(() {
    Get.testMode = true;
    final storage = FakeStorageService();
    Get.put<StorageService>(storage);
    Get.put<AuthService>(AuthService());
  });

  tearDown(() {
    EasyLoading.dismiss();
    Get.reset();
  });

  Widget buildTestHost({required Widget child}) {
    return GetMaterialApp(
      home: Scaffold(body: child),
      getPages: [
        GetPage(
            name: AppRoutes.dashboard,
            page: () => const Scaffold(body: Text('Dashboard'))),
        GetPage(
            name: AppRoutes.otp, page: () => const Scaffold(body: Text('OTP'))),
      ],
      builder: EasyLoading.init(),
    );
  }

  group('AuthController Tests', () {
    testWidgets('initial state and fields restoration', (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final mockProvider = MockAuthProvider();
      final controller = AuthController(authProvider: mockProvider);
      controller.onInit();

      expect(controller.isLoading.value, isFalse);
      expect(controller.isOtpVerifying.value, isFalse);
      expect(controller.rememberMe.value, isFalse);
      expect(controller.canResend.value, isFalse);

      controller.onClose();
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('login populates pendingUser and starts timer', (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final mockProvider = MockAuthProvider();
      final controller = AuthController(authProvider: mockProvider);
      controller.onInit();

      controller.loginEmailController.text = 'john@example.com';
      controller.loginPasswordController.text = 'secret123';

      await controller.login();
      expect(controller.pendingUser.value, isNotNull);
      expect(controller.pendingUser.value?.name, 'John Doe');
      expect(controller.pendingEmail.value, 'john@example.com');
      expect(controller.timerSeconds.value, lessThanOrEqualTo(30));
      expect(controller.timerSeconds.value, greaterThan(0));

      controller.onClose();
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('login handles exception gracefully without crashing',
        (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final mockProvider = MockAuthProvider(shouldThrow: true);
      final controller = AuthController(authProvider: mockProvider);
      controller.onInit();

      controller.loginEmailController.text = 'wrong@example.com';
      controller.loginPasswordController.text = 'wrongpass';

      await controller.login();

      expect(controller.isLoading.value, isFalse);
      expect(controller.pendingUser.value, isNull);

      controller.onClose();
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('register populates pendingUser and metadata', (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final mockProvider = MockAuthProvider();
      final controller = AuthController(authProvider: mockProvider);
      controller.onInit();

      controller.registerNameController.text = 'John Doe';
      controller.registerEmailController.text = 'john@example.com';
      controller.registerPhoneController.text = '+1234567890';
      controller.registerPasswordController.text = 'password123';
      controller.registerConfirmPasswordController.text = 'password123';

      await controller.register();

      expect(controller.pendingUser.value, isNotNull);
      expect(controller.pendingEmail.value, 'john@example.com');
      expect(controller.pendingPhone.value, '+1234567890');

      controller.onClose();
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('verifyOtp logs in user with valid OTP', (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final mockProvider = MockAuthProvider();
      final controller = AuthController(authProvider: mockProvider);
      controller.onInit();

      controller.pendingEmail.value = 'john@example.com';
      controller.pendingUser.value = mockProvider.mockUser;

      final success = await controller.verifyOtp(ApiConstants.demoOtp);

      expect(success, isTrue);
      expect(controller.isOtpVerifying.value, isFalse);
      expect(AuthService.to.isLoggedIn.value, isTrue);
      expect(AuthService.to.currentUser.value?.email, 'john@example.com');

      controller.onClose();
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('verifyOtp returns false for invalid OTP', (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final mockProvider = MockAuthProvider();
      final controller = AuthController(authProvider: mockProvider);
      controller.onInit();

      final success = await controller.verifyOtp('000000');

      expect(success, isFalse);
      expect(controller.isOtpVerifying.value, isFalse);

      controller.onClose();
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('sendPasswordReset handles submission', (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final mockProvider = MockAuthProvider();
      final controller = AuthController(authProvider: mockProvider);
      controller.onInit();

      controller.forgotPasswordEmailController.text = 'reset@example.com';
      await controller.sendPasswordReset();

      expect(controller.isLoading.value, isFalse);

      controller.onClose();
      await tester.pump(const Duration(seconds: 5));
    });
  });
}
