import 'package:flutter_core/app/data/models/post_model.dart';
import 'package:flutter_core/app/modules/search/controllers/search_controller.dart';
import 'package:flutter_core/app/modules/search/providers/search_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class MockSearchProvider extends SearchProvider {
  final List<PostModel> posts;
  final bool shouldThrow;

  MockSearchProvider({this.posts = const [], this.shouldThrow = false});

  @override
  Future<List<PostModel>> searchPosts(String query) async {
    if (shouldThrow) {
      throw Exception('Search failed');
    }
    return posts
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSearchController Tests', () {
    tearDown(() {
      Get.reset();
    });

    final samplePosts = [
      const PostModel(
        id: 1,
        userId: 1,
        title: 'Flutter GetX Guide',
        body: 'Reactive state management in Flutter',
      ),
      const PostModel(
        id: 2,
        userId: 1,
        title: 'Dart Asynchronous Programming',
        body: 'Futures and Streams in Dart',
      ),
    ];

    test('onQueryChanged updates searchQuery', () {
      final mockProvider = MockSearchProvider(posts: samplePosts);
      final controller = AppSearchController(searchProvider: mockProvider);
      controller.onInit();

      controller.onQueryChanged('Flutter');
      expect(controller.searchQuery.value, 'Flutter');

      controller.onClose();
    });

    test('clearSearch resets controller state and fields', () {
      final mockProvider = MockSearchProvider(posts: samplePosts);
      final controller = AppSearchController(searchProvider: mockProvider);
      controller.onInit();

      controller.textEditingController.text = 'query';
      controller.searchQuery.value = 'query';
      controller.searchResults.assignAll(samplePosts);
      controller.hasSearched.value = true;

      controller.clearSearch();

      expect(controller.textEditingController.text, isEmpty);
      expect(controller.searchQuery.value, isEmpty);
      expect(controller.searchResults, isEmpty);
      expect(controller.hasSearched.value, isFalse);

      controller.onClose();
    });

    test('debounced search executes after 400ms delay', () async {
      final mockProvider = MockSearchProvider(posts: samplePosts);
      final controller = AppSearchController(searchProvider: mockProvider);
      controller.onInit();

      controller.onQueryChanged('Flutter');
      expect(controller.searchResults, isEmpty);

      // Wait for 400ms debounce + async execution
      await Future.delayed(const Duration(milliseconds: 600));

      expect(controller.hasSearched.value, isTrue);
      expect(controller.searchResults.length, 1);
      expect(controller.searchResults.first.title, 'Flutter GetX Guide');

      controller.onClose();
    });

    test('empty query clears results and sets hasSearched to false', () async {
      final mockProvider = MockSearchProvider(posts: samplePosts);
      final controller = AppSearchController(searchProvider: mockProvider);
      controller.onInit();

      controller.onQueryChanged('');
      await Future.delayed(const Duration(milliseconds: 600));

      expect(controller.hasSearched.value, isFalse);
      expect(controller.searchResults, isEmpty);

      controller.onClose();
    });
  });
}
