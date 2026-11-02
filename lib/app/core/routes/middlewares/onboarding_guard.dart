import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/storage_service.dart';
import '../app_routes.dart';

class OnboardingGuard extends GetMiddleware {
  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<StorageService>()) {
      return null;
    }

    final storage = StorageService.to;
    if (!storage.isOnboardingSeen) {
      return const RouteSettings(name: AppRoutes.onboarding);
    }

    return null;
  }
}

