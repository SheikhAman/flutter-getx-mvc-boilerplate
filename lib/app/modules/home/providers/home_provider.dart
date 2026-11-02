import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../../data/models/post_model.dart';

class HomeProvider {
  final DioClient _dioClient;

  HomeProvider({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<List<PostModel>> getPosts({int page = 1, int limit = 10}) async {
    final response = await _dioClient.get(
      ApiConstants.posts,
      queryParameters: {
        '_page': page,
        '_limit': limit,
      },
    );

    if (response is List) {
      return response
          .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<PostModel> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    final response = await _dioClient.post(
      ApiConstants.posts,
      data: {
        'title': title,
        'body': body,
        'userId': userId,
      },
    );

    if (response is Map<String, dynamic>) {
      return PostModel.fromJson(response);
    }
    return PostModel(
      id: DateTime.now().millisecondsSinceEpoch,
      userId: userId,
      title: title,
      body: body,
      createdAt: DateTime.now(),
    );
  }
}

