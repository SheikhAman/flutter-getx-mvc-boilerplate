import 'package:get/get.dart';
import '../controllers/post_detail_controller.dart';
import '../providers/post_detail_provider.dart';

class PostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailProvider>(() => PostDetailProvider());
    Get.lazyPut<PostDetailController>(
      () => PostDetailController(postDetailProvider: Get.find<PostDetailProvider>()),
    );
  }
}

