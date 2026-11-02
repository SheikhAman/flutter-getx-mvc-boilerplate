import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../../data/models/post_model.dart';

class PostDetailProvider {
  final DioClient _dioClient;

  PostDetailProvider({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<PostModel> getPostDetail(int id) async {
    final response = await _dioClient.get('${ApiConstants.posts}/$id');
    if (response is Map<String, dynamic>) {
      return PostModel.fromJson(response);
    }
    throw Exception('Failed to load post details');
  }

  Future<List<Map<String, dynamic>>> getComments(int postId) async {
    final response = await _dioClient.get(
      ApiConstants.comments,
      queryParameters: {'postId': postId},
    );
    if (response is List) {
      return response.map((item) => item as Map<String, dynamic>).toList();
    }
    return [];
  }
}

