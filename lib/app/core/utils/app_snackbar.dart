import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../values/app_colors.dart';
import '../values/app_sizes.dart';
import '../values/app_strings.dart';

class AppSnackbar {
  AppSnackbar._();

  static void showSuccess(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      title ?? AppStrings.success.tr,
      message,
      snackPosition: position,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      margin: const EdgeInsets.all(AppSizes.p16),
      borderRadius: AppSizes.radiusMd,
      duration: duration,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void showError(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 4),
  }) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      title ?? AppStrings.error.tr,
      message,
      snackPosition: position,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      margin: const EdgeInsets.all(AppSizes.p16),
      borderRadius: AppSizes.radiusMd,
      duration: duration,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void showWarning(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      title ?? AppStrings.warning.tr,
      message,
      snackPosition: position,
      backgroundColor: AppColors.warning,
      colorText: Colors.white,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      margin: const EdgeInsets.all(AppSizes.p16),
      borderRadius: AppSizes.radiusMd,
      duration: duration,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void showInfo(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      title ?? AppStrings.info.tr,
      message,
      snackPosition: position,
      backgroundColor: AppColors.info,
      colorText: Colors.white,
      icon: const Icon(Icons.info_outline, color: Colors.white),
      margin: const EdgeInsets.all(AppSizes.p16),
      borderRadius: AppSizes.radiusMd,
      duration: duration,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void showLoading({String? message}) {
    EasyLoading.show(
      status: message ?? 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void dismissLoading() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}

