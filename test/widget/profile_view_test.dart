import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/app/core/services/auth_service.dart';
import 'package:flutter_core/app/core/services/storage_service.dart';
import 'package:flutter_core/app/core/values/app_strings.dart';
import 'package:flutter_core/app/data/models/user_model.dart';
import 'package:flutter_core/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_core/app/modules/profile/providers/profile_provider.dart';
import 'package:flutter_core/app/modules/profile/views/profile_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FakeStorageService extends StorageService {
  final Map<String, dynamic> _memory = {};

  @override
  T? read<T>(String key, {T? defaultValue}) =>
      (_memory[key] as T?) ?? defaultValue;

  @override
  Future<void> write(String key, dynamic value) async => _memory[key] = value;

  @override
  Future<void> remove(String key) async => _memory.remove(key);

  @override
  bool hasData(String key) => _memory.containsKey(key);

  @override
  Future<void> clearAll() async => _memory.clear();

  @override
  String? get avatarPath => read<String>(StorageService.keyAvatarPath);

  @override
  Future<void> setAvatarPath(String? path) async {
    if (path == null) {
      await remove(StorageService.keyAvatarPath);
    } else {
      await write(StorageService.keyAvatarPath, path);
    }
  }
}

class MockImagePicker extends Fake implements ImagePicker {
  final String? pathToReturn;
  final bool shouldThrow;

  MockImagePicker({this.pathToReturn, this.shouldThrow = false});

  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    if (shouldThrow) {
      throw PlatformException(
          code: 'photo_access_denied', message: 'Permission denied');
    }
    if (pathToReturn != null) {
      return XFile(pathToReturn!);
    }
    return null;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async => '.');

  late FakeStorageService storage;
  late AuthService auth;

  setUp(() {
    Get.testMode = true;
    storage = FakeStorageService();
    Get.put<StorageService>(storage);
    auth = AuthService();
    Get.put<AuthService>(auth);
    auth.currentUser.value = const UserModel(
      id: '1',
      name: 'Alex Johnson',
      email: 'alex.johnson@fluttercore.dev',
      phone: '+1 555-0199',
      role: 'Senior Developer',
    );
  });

  tearDown(() {
    EasyLoading.dismiss();
    Get.reset();
  });

  Widget buildTestHost(Widget child) {
    return GetMaterialApp(
      translations: AppStrings(),
      locale: const Locale('en', 'US'),
      home: child,
      builder: EasyLoading.init(),
    );
  }

  group('ProfileView and Controller Tests', () {
    testWidgets(
        'BUG 1 FIX: Edit Profile saves, closes bottom sheet and updates name & avatar initial',
        (tester) async {
      final controller = ProfileController(
        profileProvider: ProfileProvider(),
      );
      Get.put<ProfileController>(controller);

      await tester.pumpWidget(buildTestHost(const ProfileView()));

      // Initial check: Name and Avatar Initial 'A'
      expect(find.text('Alex Johnson'), findsOneWidget);
      expect(find.text('A'), findsOneWidget);

      // Open Edit Profile sheet
      await tester.tap(find.text('Edit Profile'));
      await tester.pumpAndSettle();

      // Bottom sheet is open
      expect(find.text('Edit Profile'), findsNWidgets(2));

      // Enter new name
      final nameField = find.widgetWithText(TextFormField, 'Alex Johnson');
      await tester.enterText(nameField, 'Jane Doe');
      await tester.pump();

      // Tap Save Changes
      await tester.tap(find.text('Save Changes'));
      await tester.pump();

      // Advance mock network delay
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      // Bottom sheet MUST BE CLOSED (only 1 occurrence on screen)
      expect(find.text('Edit Profile'), findsOneWidget);

      // Profile screen displays new name and updated avatar initial 'J'
      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('J'), findsOneWidget);
      expect(find.text('A'), findsNothing);

      // Drain snackbar animation
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets('BUG 2 FIX: Camera button opens photo source chooser',
        (tester) async {
      final controller = ProfileController(
        profileProvider: ProfileProvider(),
      );
      Get.put<ProfileController>(controller);

      await tester.pumpWidget(buildTestHost(const ProfileView()));

      // Tap camera icon button on avatar
      await tester.tap(find.byIcon(Icons.camera_alt_rounded));
      await tester.pumpAndSettle();

      // Verify Image Source Chooser opens
      expect(find.text('Profile Photo'), findsOneWidget);
      expect(find.text('Choose from Gallery'), findsOneWidget);
      expect(find.text('Take a Photo'), findsOneWidget);

      Get.back();
      await tester.pumpAndSettle();
    });

    testWidgets('BUG 2 FIX: Picking avatar persists path and survives restart',
        (tester) async {
      await tester
          .pumpWidget(buildTestHost(const Scaffold(body: Text('Host'))));

      const mockPath = '/mock/storage/user_avatar_123.jpg';
      final mockPicker = MockImagePicker(pathToReturn: mockPath);
      final controller = ProfileController(
        profileProvider: ProfileProvider(),
        imagePicker: mockPicker,
      );
      Get.put<ProfileController>(controller);

      // Pick image from gallery
      await controller.pickImage(ImageSource.gallery);
      await tester.pump();

      // Verify controller and storage state
      expect(controller.avatarPath.value, mockPath);
      expect(storage.avatarPath, mockPath);

      // Simulate app restart: Re-instantiate controller
      Get.delete<ProfileController>();
      final reloadedController = ProfileController(
        profileProvider: ProfileProvider(),
        imagePicker: mockPicker,
      );
      Get.put<ProfileController>(reloadedController);
      reloadedController.onInit();

      // Avatar path must persist from storage
      expect(reloadedController.avatarPath.value, mockPath);

      // Drain snackbar animation
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets(
        'BUG 2 FIX: Permission denied shows friendly snackbar without crash',
        (tester) async {
      await tester
          .pumpWidget(buildTestHost(const Scaffold(body: Text('Host'))));

      final mockPicker = MockImagePicker(shouldThrow: true);
      final controller = ProfileController(
        profileProvider: ProfileProvider(),
        imagePicker: mockPicker,
      );
      Get.put<ProfileController>(controller);

      // Pick image triggers permission denial
      await controller.pickImage(ImageSource.camera);
      await tester.pump();

      // Should not crash, avatarPath remains null
      expect(controller.avatarPath.value, isNull);

      // Drain snackbar animation
      await tester.pump(const Duration(seconds: 4));
    });
  });
}
