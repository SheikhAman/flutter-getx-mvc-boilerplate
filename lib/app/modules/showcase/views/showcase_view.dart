import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/loading_view.dart';
import '../controllers/showcase_controller.dart';
import '../widgets/section_header.dart';

class ShowcaseView extends GetView<ShowcaseController> {
  const ShowcaseView({super.key});

  void _showDemoDialog(BuildContext context) {
    final theme = Theme.of(context);
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        ),
        backgroundColor: theme.colorScheme.surface,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppSizes.p28),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Boilerplate Dialog',
                style: AppTextStyles.h3.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppSizes.p12),
              Text(
                'This is a standardized Material 3 dialog styled to match your active theme, color seed, and typography.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSizes.p24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.p16,
                        vertical: AppSizes.p10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.button.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.p10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(96, AppSizes.buttonHeightSm),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.p20,
                        vertical: AppSizes.p10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: Text(
                      'Confirm',
                      style: AppTextStyles.button.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackChip({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required Color lightBg,
    required VoidCallback onPressed,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? color.withAlpha(45) : lightBg;
    final fg = isDark ? color.withAlpha(235) : color;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p14,
            vertical: AppSizes.p10,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: Border.all(
              color: color.withAlpha(isDark ? 80 : 50),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: fg),
              const SizedBox(width: AppSizes.p8),
              Text(
                label,
                style: AppTextStyles.button.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
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
      appBar: CustomAppBar(
        title: AppStrings.showcase.tr,
        showBackButton: Navigator.canPop(context),
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
                _buildFeedbackChip(
                  context: context,
                  label: 'Success',
                  icon: Icons.check_circle_outline_rounded,
                  color: AppColors.success,
                  lightBg: AppColors.successLight,
                  onPressed: controller.testSuccessSnackbar,
                ),
                _buildFeedbackChip(
                  context: context,
                  label: 'Error',
                  icon: Icons.error_outline_rounded,
                  color: AppColors.error,
                  lightBg: AppColors.errorLight,
                  onPressed: controller.testErrorSnackbar,
                ),
                _buildFeedbackChip(
                  context: context,
                  label: 'Warning',
                  icon: Icons.warning_amber_rounded,
                  color: AppColors.warning,
                  lightBg: AppColors.warningLight,
                  onPressed: controller.testWarningSnackbar,
                ),
                _buildFeedbackChip(
                  context: context,
                  label: 'Info',
                  icon: Icons.info_outline_rounded,
                  color: AppColors.info,
                  lightBg: AppColors.infoLight,
                  onPressed: controller.testInfoSnackbar,
                ),
                _buildFeedbackChip(
                  context: context,
                  label: 'Loading Overlay',
                  icon: Icons.hourglass_top_rounded,
                  color: theme.colorScheme.primary,
                  lightBg: theme.colorScheme.primary.withAlpha(25),
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
