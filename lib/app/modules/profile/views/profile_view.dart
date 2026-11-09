import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  void _showEditSheet(BuildContext context) {
    controller.nameController.text = controller.user.name;
    controller.phoneController.text = controller.user.phone;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(AppSizes.p24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXl),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSizes.p20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(100),
                    borderRadius: AppSizes.borderRadiusFull,
                  ),
                ),
              ),
              Text(
                'Edit Profile',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: AppSizes.p20),
              CustomTextField(
                controller: controller.nameController,
                label: AppStrings.name.tr,
                hint: 'Your Name',
              ),
              const SizedBox(height: AppSizes.p16),
              CustomTextField(
                controller: controller.phoneController,
                label: AppStrings.phone.tr,
                hint: 'Your Phone',
              ),
              const SizedBox(height: AppSizes.p24),
              CustomButton(
                text: AppStrings.save.tr,
                onPressed: controller.updateProfile,
              ),
              const SizedBox(height: AppSizes.p12),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.profile.tr,
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: AppStrings.settings.tr,
            onPressed: () => Get.toNamed(AppRoutes.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Column(
          children: [
            // Avatar & Name Card
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Obx(() {
                        final photoPath = controller.avatarPath.value;
                        final hasPhoto = photoPath != null &&
                            photoPath.isNotEmpty &&
                            File(photoPath).existsSync();

                        return CircleAvatar(
                          radius: 48,
                          backgroundColor:
                              theme.colorScheme.primary.withAlpha(30),
                          backgroundImage:
                              hasPhoto ? FileImage(File(photoPath)) : null,
                          child: hasPhoto
                              ? null
                              : Text(
                                  controller.user.name.isNotEmpty
                                      ? controller.user.name[0].toUpperCase()
                                      : 'U',
                                  style: AppTextStyles.h1.copyWith(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                        );
                      }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: controller.showImageSourcePicker,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: theme.colorScheme.primary,
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.p16),
                  Obx(
                    () => Text(
                      controller.user.name,
                      style: AppTextStyles.h3,
                    ),
                  ),
                  const SizedBox(height: AppSizes.p4),
                  Obx(
                    () => Text(
                      controller.user.email,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color:
                            theme.textTheme.bodyMedium?.color?.withAlpha(160),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.p8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.p12, vertical: AppSizes.p4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withAlpha(20),
                      borderRadius: AppSizes.borderRadiusFull,
                    ),
                    child: Text(
                      controller.user.role ?? 'Member',
                      style: AppTextStyles.caption.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.p32),

            // Profile Actions
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: AppSizes.borderRadiusMd,
                side: BorderSide(
                  color: isDark
                      ? const Color(0xFF2C2C2C)
                      : const Color(0xFFE5E7EB),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text('Edit Profile'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () => _showEditSheet(context),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: Text(AppStrings.settings.tr),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () => Get.toNamed(AppRoutes.settings),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.help_outline_rounded),
                    title: const Text('Help & Documentation'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () => Get.toNamed(
                      AppRoutes.webview,
                      arguments: {
                        'title': 'Documentation',
                        'url': 'https://flutter.dev',
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.p32),

            // Logout Button
            CustomButton.outline(
              text: AppStrings.logout.tr,
              icon: Icons.logout_rounded,
              textColor: Colors.red,
              onPressed: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}
