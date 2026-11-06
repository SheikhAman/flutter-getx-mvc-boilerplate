import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_snackbar.dart';

class ShowcaseController extends GetxController {
  final RxBool isButtonLoading = false.obs;
  final demoInputController = TextEditingController();

  void toggleButtonLoading() {
    isButtonLoading.value = !isButtonLoading.value;
    if (isButtonLoading.value) {
      Future.delayed(const Duration(seconds: 2), () {
        isButtonLoading.value = false;
      });
    }
  }

  void testSuccessSnackbar() {
    AppSnackbar.showSuccess('Operation completed successfully!');
  }

  void testErrorSnackbar() {
    AppSnackbar.showError('Something went wrong. Please check your data.');
  }

  void testWarningSnackbar() {
    AppSnackbar.showWarning('Please be cautious with this action.');
  }

  void testInfoSnackbar() {
    AppSnackbar.showInfo('New update is available in the store.');
  }

  void testLoadingOverlay() {
    AppSnackbar.showLoading(message: 'Processing request...');
    Future.delayed(const Duration(seconds: 2), () {
      AppSnackbar.dismissLoading();
      AppSnackbar.showSuccess('Done!');
    });
  }

  @override
  void onClose() {
    demoInputController.dispose();
    super.onClose();
  }
}
