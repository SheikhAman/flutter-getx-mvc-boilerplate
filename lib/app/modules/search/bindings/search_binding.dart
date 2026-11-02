import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../providers/search_provider.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchProvider>(() => SearchProvider());
    Get.lazyPut<AppSearchController>(
      () => AppSearchController(searchProvider: Get.find<SearchProvider>()),
    );
  }
}

