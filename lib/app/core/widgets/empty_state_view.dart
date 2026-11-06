import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../values/app_colors.dart';
import '../values/app_sizes.dart';
import '../values/app_strings.dart';
import '../values/app_text_styles.dart';
import 'custom_button.dart';

class EmptyStateView extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData icon;
  final String? actionText;
  final VoidCallback? onAction;
  final double iconSize;

  const EmptyStateView({
    super.key,
    this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.actionText,
    this.onAction,
    this.iconSize = 72.0,
  });

  const EmptyStateView.error({
    super.key,
    this.title,
    this.subtitle,
    this.icon = Icons.wifi_off_rounded,
    this.actionText,
    this.onAction,
    this.iconSize = 72.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.p20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.grey800 : AppColors.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: theme.colorScheme.primary.withAlpha(200),
              ),
            ),
            const SizedBox(height: AppSizes.p20),
            Text(
              title ?? AppStrings.emptyTitle.tr,
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.p8),
            Text(
              subtitle ?? AppStrings.emptySub.tr,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (onAction != null) ...[
              const SizedBox(height: AppSizes.p24),
              CustomButton(
                text: actionText ?? AppStrings.retry.tr,
                onPressed: onAction,
                width: 180,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
