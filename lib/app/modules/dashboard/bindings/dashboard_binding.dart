import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/providers/home_provider.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../profile/providers/profile_provider.dart';
import '../../search/controllers/search_controller.dart';
import '../../search/providers/search_provider.dart';
import '../../showcase/controllers/showcase_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());

    // Tab dependencies
    Get.lazyPut<HomeProvider>(() => HomeProvider());
    Get.lazyPut<HomeController>(() => HomeController(homeProvider: Get.find<HomeProvider>()));

    Get.lazyPut<SearchProvider>(() => SearchProvider());
    Get.lazyPut<AppSearchController>(
      () => AppSearchController(searchProvider: Get.find<SearchProvider>()),
    );

    Get.lazyPut<ShowcaseController>(() => ShowcaseController());

    Get.lazyPut<ProfileProvider>(() => ProfileProvider());
    Get.lazyPut<ProfileController>(
      () => ProfileController(profileProvider: Get.find<ProfileProvider>()),
    );
  }
}

