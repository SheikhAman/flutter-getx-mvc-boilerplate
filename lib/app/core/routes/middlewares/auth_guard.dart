import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth_service.dart';
import '../app_routes.dart';

class AuthGuard extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<AuthService>()) {
      return null;
    }

    final authService = AuthService.to;
    if (!authService.isLoggedIn.value) {
      return const RouteSettings(name: AppRoutes.login);
    }

    return null;
  }
}
