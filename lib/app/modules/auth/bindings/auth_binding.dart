import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../providers/auth_provider.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.lazyPut<AuthController>(
        () => AuthController(authProvider: Get.find<AuthProvider>()));
  }
}
