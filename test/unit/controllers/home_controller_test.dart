import 'package:flutter_core/app/data/models/post_model.dart';
import 'package:flutter_core/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_core/app/modules/home/providers/home_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class MockHomeProvider extends HomeProvider {
  final List<PostModel> postsToReturn;
  final bool shouldThrow;

  MockHomeProvider({this.postsToReturn = const [], this.shouldThrow = false});

  @override
  Future<List<PostModel>> getPosts({int page = 1, int limit = 10}) async {
    if (shouldThrow) {
      throw Exception('Failed to fetch posts');
    }
    return postsToReturn;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeController Tests', () {
    tearDown(() {
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
  });
}
