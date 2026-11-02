import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/storage_service.dart';

class SplashController extends GetxController {
  bool _hasNavigated = false;

  @override
  void onInit() {
    super.onInit();
    _handleNavigation();
  }

  @override
  void onReady() {
    super.onReady();
    if (!_hasNavigated) {
      _handleNavigation();
    }
  }

  Future<void> _handleNavigation() async {
    if (_hasNavigated) return;
    _hasNavigated = true;

    await Future.delayed(const Duration(seconds: 2));

    try {
      final storage = StorageService.to;
      if (!storage.isOnboardingSeen) {
        Get.offAllNamed(AppRoutes.onboarding);
        return;
      }

      final auth = AuthService.to;
      if (auth.isLoggedIn.value) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (_) {
      // Fallback navigation in case of unexpected state
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
