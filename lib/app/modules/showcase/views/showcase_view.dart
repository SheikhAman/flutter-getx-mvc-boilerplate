import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/loading_view.dart';
import '../controllers/showcase_controller.dart';
import '../widgets/section_header.dart';

class ShowcaseView extends GetView<ShowcaseController> {
  const ShowcaseView({super.key});

  void _showDemoDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Boilerplate Dialog',
      middleText:
          'This is a standardized GetX dialog styled for enterprise apps.',
      textConfirm: 'Confirm',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void _showDemoBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(AppSizes.p24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXl),
          ),
        ),
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
            const Text('Modal Bottom Sheet', style: AppTextStyles.h3),
            const SizedBox(height: AppSizes.p8),
            const Text(
              'Easily present forms, selections, or filter dialogs directly in the user workflow.',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: AppSizes.p24),
            CustomButton(
              text: 'Dismiss',
              onPressed: () => Get.back(),
            ),
            const SizedBox(height: AppSizes.p12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.showcase.tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Container(
              padding: const EdgeInsets.all(AppSizes.p16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(20),
                borderRadius: AppSizes.borderRadiusMd,
                border:
                    Border.all(color: theme.colorScheme.primary.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.palette_outlined,
                      color: theme.colorScheme.primary, size: 32),
                  const SizedBox(width: AppSizes.p12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Design System & Tokens',
                            style: AppTextStyles.titleLarge),
                        Text(
                          'Test UI primitives, controls, and reactive triggers.',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Section 1: Buttons
            const SectionHeader(
              title: '1. Custom Buttons',
              subtitle: 'Variants, icons, full width and loading states',
            ),
            CustomButton(
              text: 'Primary Button',
              icon: Icons.check_circle_outline,
              onPressed: () {},
            ),
            const SizedBox(height: AppSizes.p12),
            CustomButton.secondary(
              text: 'Secondary Button',
              icon: Icons.layers_outlined,
              onPressed: () {},
            ),
            const SizedBox(height: AppSizes.p12),
            CustomButton.outline(
              text: 'Outline Button',
              icon: Icons.crop_square_outlined,
              onPressed: () {},
            ),
            const SizedBox(height: AppSizes.p12),
            CustomButton.text(
              text: 'Text Button',
              onPressed: () {},
            ),
            const SizedBox(height: AppSizes.p12),
            Obx(
              () => CustomButton(
                text: 'Loading State Button',
                isLoading: controller.isButtonLoading.value,
                onPressed: controller.toggleButtonLoading,
              ),
            ),

            // Section 2: Form Inputs
            const SectionHeader(
              title: '2. Form Input Fields',
              subtitle: 'Floating labels, prefixes, password toggle',
            ),
            CustomTextField(
              label: 'Standard Input',
              hint: 'Enter some text...',
              prefixIcon: const Icon(Icons.edit_outlined),
            ),
            const SizedBox(height: AppSizes.p16),
            CustomTextField(
              label: 'Password Input',
              hint: 'Enter secure password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              isPassword: true,
            ),
            const SizedBox(height: AppSizes.p16),
            CustomTextField(
              label: 'Multiline Note',
              hint: 'Write multi-line thoughts...',
              maxLines: 3,
            ),

            // Section 3: Snackbars & Feedback
            const SectionHeader(
              title: '3. Snackbars & Notifications',
              subtitle: 'Universal, responsive feedback handlers',
            ),
            Wrap(
              spacing: AppSizes.p8,
              runSpacing: AppSizes.p8,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.check_circle, size: 16),
                  label: const Text('Success'),
                  onPressed: controller.testSuccessSnackbar,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.error_outline, size: 16),
                  label: const Text('Error'),
                  onPressed: controller.testErrorSnackbar,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warning,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.warning_amber_rounded, size: 16),
                  label: const Text('Warning'),
                  onPressed: controller.testWarningSnackbar,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.info,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.info_outline, size: 16),
                  label: const Text('Info'),
                  onPressed: controller.testInfoSnackbar,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.hourglass_top, size: 16),
                  label: const Text('Loading Overlay'),
                  onPressed: controller.testLoadingOverlay,
                ),
              ],
            ),

            // Section 4: Dialogs & Sheets
            const SectionHeader(
              title: '4. Modals & Dialogs',
              subtitle: 'GetX styled dialogs and bottom sheets',
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton.outline(
                    text: 'Show Dialog',
                    icon: Icons.open_in_new_rounded,
                    onPressed: () => _showDemoDialog(context),
                  ),
                ),
                const SizedBox(width: AppSizes.p12),
                Expanded(
                  child: CustomButton.outline(
                    text: 'Bottom Sheet',
                    icon: Icons.vertical_align_top_rounded,
                    onPressed: () => _showDemoBottomSheet(context),
                  ),
                ),
              ],
            ),

            // Section 5: Shimmer Loader Demo
            const SectionHeader(
              title: '5. Shimmer Skeleton Preview',
              subtitle: 'Loading skeletons for smooth UX',
            ),
            Container(
              padding: const EdgeInsets.all(AppSizes.p16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: AppSizes.borderRadiusMd,
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF2C2C2C)
                      : const Color(0xFFE5E7EB),
                ),
              ),
              child: Row(
                children: [
                  const ShimmerSkeleton(
                      width: 44, height: 44, borderRadius: AppSizes.radiusFull),
                  const SizedBox(width: AppSizes.p12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerSkeleton(width: 140, height: 14),
                        SizedBox(height: AppSizes.p6),
                        ShimmerSkeleton(width: 80, height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Section 6: Typography Scale
            const SectionHeader(
              title: '6. Typography Scale',
              subtitle: 'Consistent, cached text styles',
            ),
            Text('Display Heading 1', style: AppTextStyles.h1),
            Text('Display Heading 2', style: AppTextStyles.h2),
            Text('Section Heading 3', style: AppTextStyles.h3),
            Text('Subheading 4', style: AppTextStyles.h4),
            Text('Body Large - 16px Regular line height 1.5',
                style: AppTextStyles.bodyLarge),
            Text('Body Medium - 14px Regular standard body',
                style: AppTextStyles.bodyMedium),
            Text('Caption - 11px Muted metadata text',
                style: AppTextStyles.caption),

            const SizedBox(height: AppSizes.p48),
          ],
        ),
      ),
    );
  }
}
