import 'package:get/get.dart';
import '../../../data/models/post_model.dart';
import '../providers/post_detail_provider.dart';

class PostDetailController extends GetxController {
  final PostDetailProvider provider;

  PostDetailController({PostDetailProvider? postDetailProvider})
      : provider = postDetailProvider ?? PostDetailProvider();

  final Rxn<PostModel> post = Rxn<PostModel>();
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> comments = <Map<String, dynamic>>[].obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLiked = false.obs;
  final RxInt likesCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _extractArguments();
  }

  void _extractArguments() {
    final args = Get.arguments;

    if (args is PostModel) {
      post.value = args;
      likesCount.value = args.likesCount;
      fetchComments(args.id);
    } else if (args is int) {
      fetchPostDetail(args);
    } else if (args is Map && args['id'] != null) {
      final id = int.tryParse(args['id'].toString()) ?? 1;
      fetchPostDetail(id);
    } else {
      // Fallback
      fetchPostDetail(1);
    }
  }

  Future<void> fetchPostDetail(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fetched = await provider.getPostDetail(id);
      post.value = fetched;
      likesCount.value = fetched.likesCount;
      await fetchComments(id);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchComments(int postId) async {
    try {
      final result = await provider.getComments(postId);
      comments.assignAll(result);
    } catch (_) {
      // Comments optional
    }
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
    if (isLiked.value) {
      likesCount.value++;
    } else {
      likesCount.value--;
    }
  }
}
