import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../data/models/user_model.dart';
import '../providers/profile_provider.dart';

class ProfileController extends GetxController {
  final ProfileProvider provider;
  final ImagePicker _imagePicker;

  ProfileController({
    ProfileProvider? profileProvider,
    ImagePicker? imagePicker,
  })  : provider = profileProvider ?? ProfileProvider(),
        _imagePicker = imagePicker ?? ImagePicker();

  final AuthService authService = AuthService.to;

  final RxBool isUpdating = false.obs;
  final RxnString avatarPath = RxnString();
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
    if (Get.isRegistered<StorageService>()) {
      avatarPath.value = StorageService.to.avatarPath;
    }
  }

  void showImageSourcePicker() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(AppSizes.p20),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXl),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSizes.p16),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(100),
                  borderRadius: AppSizes.borderRadiusFull,
                ),
              ),
              const Text(
                'Profile Photo',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: AppSizes.p16),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Get.back();
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take a Photo'),
                onTap: () {
                  Get.back();
                  pickImage(ImageSource.camera);
                },
              ),
              if (avatarPath.value != null && avatarPath.value!.isNotEmpty) ...[
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text(
                    'Remove Photo',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Get.back();
                    removeAvatar();
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        avatarPath.value = image.path;
        if (Get.isRegistered<StorageService>()) {
          await StorageService.to.setAvatarPath(image.path);
        }
        await authService.updateUser(user.copyWith(avatar: image.path));
        AppSnackbar.showSuccess('Avatar updated successfully');
      }
    } catch (e) {
      AppSnackbar.showError(
        'Could not access ${source == ImageSource.camera ? 'camera' : 'gallery'}. Please check permissions.',
      );
    }
  }

  Future<void> removeAvatar() async {
    avatarPath.value = null;
    if (Get.isRegistered<StorageService>()) {
      await StorageService.to.setAvatarPath(null);
    }
    await authService.updateUser(user.copyWith(avatar: ''));
    AppSnackbar.showSuccess('Avatar removed');
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
      Get.back();
      AppSnackbar.showSuccess('Profile updated successfully');
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
