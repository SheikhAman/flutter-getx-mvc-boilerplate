import 'package:get/get.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/services/storage_service.dart';
import '../../../data/models/post_model.dart';
import '../../home/controllers/home_controller.dart';

class SearchProvider {
  final DioClient _dioClient;

  SearchProvider({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<List<PostModel>> searchPosts(String query) async {
    final lower = query.trim().toLowerCase();
    if (lower.isEmpty) return [];

    final List<PostModel> results = [];
    final Set<String> seenKeys = {};

    // 1. Check custom posts persisted in local storage
    if (Get.isRegistered<StorageService>()) {
      final customJsonList = StorageService.to.customPosts;
      for (final json in customJsonList) {
        final post = PostModel.fromJson(json);
        if (post.title.toLowerCase().contains(lower) ||
            post.body.toLowerCase().contains(lower)) {
          final key = '${post.id}_${post.title}';
          if (seenKeys.add(key)) {
            results.add(post);
          }
        }
      }
    }

    // 2. Check active in-memory HomeController posts (for immediate discovery after post creation)
    if (Get.isRegistered<HomeController>()) {
      final homePosts = Get.find<HomeController>().posts;
      for (final post in homePosts) {
        if (post.title.toLowerCase().contains(lower) ||
            post.body.toLowerCase().contains(lower)) {
          final key = '${post.id}_${post.title}';
          if (seenKeys.add(key)) {
            results.add(post);
          }
        }
      }
    }

    // 3. Query remote mock API posts
    try {
      final response = await _dioClient.get(ApiConstants.posts);
      if (response is List) {
        final all = response
            .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
            .toList();

        for (final post in all) {
          if (post.title.toLowerCase().contains(lower) ||
              post.body.toLowerCase().contains(lower)) {
            final key = '${post.id}_${post.title}';
            if (seenKeys.add(key)) {
              results.add(post);
            }
          }
        }
      }
    } catch (_) {
      // If network fails or offline, still return matched local/custom posts
    }

    return results;
  }
}
