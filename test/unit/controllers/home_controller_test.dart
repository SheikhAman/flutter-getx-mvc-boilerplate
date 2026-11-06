import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_core/app/data/models/post_model.dart';
import 'package:flutter_core/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_core/app/modules/home/providers/home_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class MockHomeProvider extends HomeProvider {
  final List<PostModel> postsToReturn;
  final bool shouldThrow;
  final bool shouldThrowOnCreate;
  final Completer<PostModel>? createCompleter;

  MockHomeProvider({
    this.postsToReturn = const [],
    this.shouldThrow = false,
    this.shouldThrowOnCreate = false,
    this.createCompleter,
  });

  @override
  Future<List<PostModel>> getPosts({int page = 1, int limit = 10}) async {
    if (shouldThrow) {
      throw Exception('Failed to fetch posts');
    }
    return postsToReturn;
  }

  @override
  Future<PostModel> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    if (shouldThrowOnCreate) {
      throw Exception('Failed to create post');
    }
    if (createCompleter != null) {
      return createCompleter!.future;
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

  Widget buildTestHost({required Widget child}) {
    return GetMaterialApp(
      home: Scaffold(body: child),
      builder: EasyLoading.init(),
    );
  }

  group('HomeController Tests', () {
    tearDown(() {
      EasyLoading.dismiss();
      Get.reset();
    });

    List<PostModel> generatePosts(int count) {
      return List.generate(
        count,
        (i) => PostModel(
          id: i + 1,
          userId: 1,
          title: 'Post ${i + 1}',
          body: 'Body ${i + 1}',
          likesCount: i * 5,
        ),
      );
    }

    test('fetchPosts populates posts list on success', () async {
      final samplePosts = generatePosts(5);
      final mockProvider = MockHomeProvider(postsToReturn: samplePosts);
      final controller = HomeController(homeProvider: mockProvider);

      await controller.fetchPosts();

      expect(controller.isLoading.value, isFalse);
      expect(controller.posts.length, 5);
      expect(controller.posts.first.title, 'Post 1');
      expect(controller.errorMessage.value, isEmpty);
      expect(controller.hasMore.value, isFalse); // < pageLimit (10)
    });

    test('fetchPosts sets errorMessage on provider exception', () async {
      final mockProvider = MockHomeProvider(shouldThrow: true);
      final controller = HomeController(homeProvider: mockProvider);

      await controller.fetchPosts();

      expect(controller.isLoading.value, isFalse);
      expect(controller.posts, isEmpty);
      expect(controller.errorMessage.value, contains('Failed to fetch posts'));
    });

    test('fetchPosts with isRefresh resets currentPage and replaces posts',
        () async {
      final samplePosts = generatePosts(5);
      final mockProvider = MockHomeProvider(postsToReturn: samplePosts);
      final controller = HomeController(homeProvider: mockProvider);

      await controller.fetchPosts();
      expect(controller.posts.length, 5);

      // Refresh
      await controller.fetchPosts(isRefresh: true);
      expect(controller.currentPage.value, 1);
      expect(controller.posts.length, 5);
    });

    test('loadMore appends additional posts when hasMore is true', () async {
      // Return exactly 10 posts so hasMore stays true
      final initialPosts = generatePosts(10);
      final mockProvider = MockHomeProvider(postsToReturn: initialPosts);
      final controller = HomeController(homeProvider: mockProvider);

      await controller.fetchPosts();
      expect(controller.posts.length, 10);
      expect(controller.hasMore.value, isTrue);

      await controller.loadMore();
      expect(controller.posts.length, 20);
      expect(controller.currentPage.value, 2);
    });

    testWidgets('createPost inserts new post at top of feed on success',
        (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final initialPosts = generatePosts(3);
      final mockProvider = MockHomeProvider(postsToReturn: initialPosts);
      final controller = HomeController(homeProvider: mockProvider);
      await controller.fetchPosts();
      expect(controller.posts.length, 3);

      final success = await controller.createPost(
        'New Awesome Post',
        'Post content body',
      );

      expect(success, isTrue);
      expect(controller.isSubmitting.value, isFalse);
      expect(controller.posts.length, 4);
      expect(controller.posts.first.title, 'New Awesome Post');
      expect(controller.posts.first.body, 'Post content body');

      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets(
        'createPost blocks duplicate submission while already submitting',
        (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final initialPosts = generatePosts(2);
      final completer = Completer<PostModel>();
      final mockProvider = MockHomeProvider(
        postsToReturn: initialPosts,
        createCompleter: completer,
      );
      final controller = HomeController(homeProvider: mockProvider);
      await controller.fetchPosts();
      expect(controller.posts.length, 2);

      // Trigger first submission (in flight via completer)
      final future1 = controller.createPost('First Post', 'Body 1');
      expect(controller.isSubmitting.value, isTrue);

      // Trigger immediate second submission (should be blocked by guard)
      final result2 = await controller.createPost('Duplicate Post', 'Body 2');
      expect(result2, isFalse);

      // Complete the first submission
      completer.complete(
        const PostModel(
          id: 999,
          userId: 1,
          title: 'First Post',
          body: 'Body 1',
        ),
      );
      final result1 = await future1;
      expect(result1, isTrue);
      expect(controller.isSubmitting.value, isFalse);

      // Only one new post should have been inserted
      expect(controller.posts.length, 3);
      expect(controller.posts.first.title, 'First Post');

      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets('createPost handles error gracefully without duplicating posts',
        (tester) async {
      await tester.pumpWidget(buildTestHost(child: Container()));
      final initialPosts = generatePosts(2);
      final mockProvider = MockHomeProvider(
        postsToReturn: initialPosts,
        shouldThrowOnCreate: true,
      );
      final controller = HomeController(homeProvider: mockProvider);
      await controller.fetchPosts();

      final success = await controller.createPost('Failed Post', 'Body');
      expect(success, isFalse);
      expect(controller.isSubmitting.value, isFalse);
      expect(controller.posts.length, 2);

      await tester.pump(const Duration(seconds: 4));
    });
  });
}
