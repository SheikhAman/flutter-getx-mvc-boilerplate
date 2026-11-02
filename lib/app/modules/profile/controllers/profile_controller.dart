import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../../core/values/app_strings.dart';
import '../../../data/models/user_model.dart';
import '../providers/profile_provider.dart';

class ProfileController extends GetxController {
  final ProfileProvider provider;

  ProfileController({ProfileProvider? profileProvider})
      : provider = profileProvider ?? ProfileProvider();

  final AuthService authService = AuthService.to;

  final RxBool isUpdating = false.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  UserModel get user =>
      authService.currentUser.value ??
      const UserModel(
        id: '1',
        name: 'Alex Johnson',
        email: 'alex.johnson@fluttercore.dev',
        phone: '+1 555-0199',
        role: 'Senior Developer',
      );

  @override
  void onInit() {
    super.onInit();
    nameController.text = user.name;
    phoneController.text = user.phone;
  }

  Future<void> updateProfile() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty) {
      AppSnackbar.showError(AppStrings.fieldRequired.tr);
      return;
    }

    try {
      isUpdating.value = true;
      AppSnackbar.showLoading();

      final updated = await provider.updateProfile(
        id: user.id,
        name: name,
        phone: phone,
      );

      await authService.updateUser(
        user.copyWith(name: updated.name, phone: updated.phone),
      );

      AppSnackbar.dismissLoading();
      AppSnackbar.showSuccess('Profile updated successfully');
      Get.back();
    } catch (e) {
      AppSnackbar.dismissLoading();
      AppSnackbar.showError(e.toString());
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> logout() async {
    Get.defaultDialog(
      title: AppStrings.logout.tr,
      middleText: AppStrings.logoutConfirm.tr,
      textConfirm: AppStrings.logout.tr,
      textCancel: AppStrings.cancel.tr,
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        await authService.logout();
      },
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}

