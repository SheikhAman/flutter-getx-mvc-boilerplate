import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../../data/models/post_model.dart';

class SearchProvider {
  final DioClient _dioClient;

  SearchProvider({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<List<PostModel>> searchPosts(String query) async {
    final response = await _dioClient.get(ApiConstants.posts);
    if (response is List) {
      final all = response
          .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
          .toList();

      final lower = query.toLowerCase();
      return all
          .where((post) =>
              post.title.toLowerCase().contains(lower) ||
              post.body.toLowerCase().contains(lower))
          .toList();
    }
    return [];
  }
}

