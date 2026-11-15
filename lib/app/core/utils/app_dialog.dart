import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../values/app_colors.dart';
import '../values/app_sizes.dart';
import '../values/app_strings.dart';
import '../values/app_text_styles.dart';

class AppDialog {
  AppDialog._();

  /// Shows a production-grade Material 3 confirmation dialog.
  ///
  /// Adheres strictly to the active theme, color seed, and typography.
  /// If [isDestructive] is true, the confirm button uses [AppColors.error] (red)
  /// to clearly signal a destructive action (like Logout or Delete).
  static Future<bool?> confirm({
    String? title,
    required String message,
    String? confirmText,
    String? cancelText,
    Color? confirmButtonColor,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDestructive = false,
  }) {
    final context = Get.context;
    final theme = context != null ? Theme.of(context) : null;
    final primaryColor = theme?.colorScheme.primary ?? AppColors.primary;
    final surfaceColor = theme?.colorScheme.surface ?? Colors.white;
    final onSurfaceColor =
        theme?.colorScheme.onSurface ?? AppColors.textPrimaryLight;
    final onSurfaceVariantColor =
        theme?.colorScheme.onSurfaceVariant ?? AppColors.textSecondaryLight;

    final effectiveConfirmColor =
        confirmButtonColor ?? (isDestructive ? AppColors.error : primaryColor);

    return Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        ),
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppSizes.p28),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null && title.isNotEmpty) ...[
                Text(
                  title,
                  style: AppTextStyles.h3.copyWith(
                    color: onSurfaceColor,
                  ),
                ),
                const SizedBox(height: AppSizes.p12),
              ],
              Text(
                message,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: onSurfaceVariantColor,
                ),
              ),
              const SizedBox(height: AppSizes.p24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(result: false);
                      onCancel?.call();
                    },
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
                      cancelText ?? AppStrings.cancel.tr,
                      style: AppTextStyles.button.copyWith(
                        color: onSurfaceVariantColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.p10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(96, AppSizes.buttonHeightSm),
                      backgroundColor: effectiveConfirmColor,
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
                    onPressed: () {
                      Get.back(result: true);
                      onConfirm?.call();
                    },
                    child: Text(
                      confirmText ??
                          (isDestructive
                              ? AppStrings.logout.tr
                              : AppStrings.confirm.tr),
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
}
