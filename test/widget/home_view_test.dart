import 'package:flutter/material.dart';
import 'package:flutter_core/app/core/values/app_strings.dart';
import 'package:flutter_core/app/core/widgets/custom_button.dart';
import 'package:flutter_core/app/data/models/post_model.dart';
import 'package:flutter_core/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_core/app/modules/home/providers/home_provider.dart';
import 'package:flutter_core/app/modules/home/views/home_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class MockHomeProviderForWidget extends HomeProvider {
  final List<PostModel> postsToReturn;
  final Duration createDelay;

  MockHomeProviderForWidget({
    this.postsToReturn = const [],
    this.createDelay = Duration.zero,
  });

  @override
  Future<List<PostModel>> getPosts({int page = 1, int limit = 10}) async {
    return postsToReturn;
  }

  @override
  Future<PostModel> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    if (createDelay > Duration.zero) {
      await Future.delayed(createDelay);
    }
    return PostModel(
      id: 999,
      userId: userId,
      title: title,
      body: body,
      likesCount: 0,
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  group('HomeView Create Post Sheet Tests', () {
    testWidgets(
        'Tapping Add icon opens Create Post sheet, submit closes sheet and displays new post',
        (tester) async {
      final initialPosts = [
        const PostModel(
          id: 1,
          userId: 1,
          title: 'Existing Post 1',
          body: 'Content 1',
          likesCount: 10,
        ),
      ];

      final provider = MockHomeProviderForWidget(postsToReturn: initialPosts);
      final controller = HomeController(homeProvider: provider);
      Get.put<HomeController>(controller);

      await tester.pumpWidget(buildTestHost(const HomeView()));
      await tester.pumpAndSettle();

      // Initial feed state
      expect(find.text('Existing Post 1'), findsOneWidget);

      // Tap + button to open Create Post bottom sheet
      await tester.tap(find.byIcon(Icons.add_circle_outline_rounded));
      await tester.pumpAndSettle();

      // Bottom sheet is visible
      expect(find.text('Create Post'), findsWidgets);
      expect(find.text('Submit'), findsOneWidget);

      // Enter Title and Content
      final titleFinder = find.widgetWithText(TextField, 'Enter title...');
      final bodyFinder = find.widgetWithText(TextField, 'Enter content...');

      await tester.enterText(titleFinder, 'My Brand New Post');
      await tester.enterText(bodyFinder, 'Awesome body content');
      await tester.pump();

      // Tap Submit
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Verify bottom sheet is CLOSED: 'Create Post' title is gone
      expect(find.text('Enter title...'), findsNothing);

      // Verify new post appears at the top of the feed exactly once
      expect(find.text('My Brand New Post'), findsOneWidget);
      expect(controller.posts.length, 2);
      expect(controller.posts.first.title, 'My Brand New Post');

      // Wait out snackbar animation
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets(
        'Submit button is guarded while submitting and prevents duplicate posts',
        (tester) async {
      final initialPosts = [
        const PostModel(
          id: 1,
          userId: 1,
          title: 'Post 1',
          body: 'Content 1',
          likesCount: 5,
        ),
      ];

      final provider = MockHomeProviderForWidget(
        postsToReturn: initialPosts,
        createDelay: const Duration(milliseconds: 50),
      );
      final controller = HomeController(homeProvider: provider);
      Get.put<HomeController>(controller);

      await tester.pumpWidget(buildTestHost(const HomeView()));
      await tester.pumpAndSettle();

      // Open sheet
      await tester.tap(find.byIcon(Icons.add_circle_outline_rounded));
      await tester.pumpAndSettle();

      final titleFinder = find.widgetWithText(TextField, 'Enter title...');
      await tester.enterText(titleFinder, 'Single Post Title');
      await tester.pump();

      // Tap Submit
      final submitButtonFinder = find.byType(CustomButton);
      expect(submitButtonFinder, findsOneWidget);

      await tester.tap(submitButtonFinder);
      await tester.pump();

      // Controller isSubmitting is true and button shows CircularProgressIndicator
      expect(controller.isSubmitting.value, isTrue);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Second tap while isSubmitting is true (button disabled / onPressed is null)
      await tester.tap(submitButtonFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Bottom sheet should close
      expect(find.text('Enter title...'), findsNothing);

      // Exactly ONE post with this title should exist in controller and UI
      expect(find.text('Single Post Title'), findsOneWidget);
      expect(controller.posts.length, 2);
      expect(
        controller.posts.where((p) => p.title == 'Single Post Title').length,
        1,
      );

      // Wait out snackbar
      await tester.pump(const Duration(seconds: 4));
    });
  });
}
