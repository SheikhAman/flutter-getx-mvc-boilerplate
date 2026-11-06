import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.settings.tr,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.p20),
        children: [
          // Section: Appearance
          Text(
            AppStrings.appearance.tr,
            style: AppTextStyles.label.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.p12),

          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: AppSizes.borderRadiusMd,
              side: BorderSide(
                color:
                    isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE5E7EB),
              ),
            ),
            child: Column(
              children: [
                // Dark Mode Switch
                Obx(
                  () => SwitchListTile(
                    secondary: Icon(
                      controller.themeController.isDarkMode.value
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: theme.colorScheme.primary,
                    ),
                    title: Text(AppStrings.darkMode.tr),
                    subtitle: Text(
                      controller.themeController.isDarkMode.value
                          ? AppStrings.darkMode.tr
                          : AppStrings.lightMode.tr,
                      style: AppTextStyles.caption,
                    ),
                    value: controller.themeController.isDarkMode.value,
                    onChanged: (_) => controller.toggleTheme(),
                  ),
                ),
                const Divider(height: 1),

                // Language Switch
                Obx(
                  () => SwitchListTile(
                    secondary: Icon(
                      Icons.language_rounded,
                      color: theme.colorScheme.primary,
                    ),
                    title: Text(AppStrings.language.tr),
                    subtitle: Text(
                      controller.localeService.isBengali
                          ? AppStrings.bengali.tr
                          : AppStrings.english.tr,
                      style: AppTextStyles.caption,
                    ),
                    value: controller.localeService.isBengali,
                    onChanged: (_) => controller.toggleLanguage(),
                  ),
                ),
                const Divider(height: 1),

                // Primary Accent Palette Seeds
                Padding(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.primaryColor.tr,
                        style: AppTextStyles.titleMedium,
                      ),
                      const SizedBox(height: AppSizes.p12),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            AppColors.seeds.length,
                            (index) {
                              final seed = AppColors.seeds[index];
                              final isSelected =
                                  controller.primaryColorIndex == index;
                              return GestureDetector(
                                onTap: () => controller.selectColorSeed(index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: seed,
                                    shape: BoxShape.circle,
                                    border: isSelected
                                        ? Border.all(
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            width: 3,
                                          )
                                        : null,
                                    boxShadow: [
                                      if (isSelected)
                                        BoxShadow(
                                          color: seed.withAlpha(120),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                    ],
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check,
                                          color: Colors.white, size: 20)
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.p28),

          // Section: About
          Text(
            AppStrings.aboutApp.tr,
            style: AppTextStyles.label.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.p12),

          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: AppSizes.borderRadiusMd,
              side: BorderSide(
                color:
                    isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE5E7EB),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: Text(AppStrings.appName.tr),
                  subtitle:
                      const Text('Enterprise GetX Modular MVC+S Boilerplate'),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withAlpha(20),
                      borderRadius: AppSizes.borderRadiusFull,
                    ),
                    child: Text(
                      'v1.0.0',
                      style: AppTextStyles.caption.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.code_rounded),
                  title: const Text('Architecture'),
                  subtitle: const Text(
                      'Modular GetX MVC+S (Model-View-Controller-Service)'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
