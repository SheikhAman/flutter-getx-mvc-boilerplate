import 'package:flutter/material.dart';
import '../values/app_colors.dart';
import '../values/app_sizes.dart';
import '../values/app_text_styles.dart';

enum ButtonVariant { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonVariant variant;
  final IconData? icon;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.width,
    this.height = AppSizes.buttonHeightMd,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = AppSizes.radiusMd,
  });

  const CustomButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = AppSizes.buttonHeightMd,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = AppSizes.radiusMd,
  }) : variant = ButtonVariant.secondary;

  const CustomButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = AppSizes.buttonHeightMd,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = AppSizes.radiusMd,
  }) : variant = ButtonVariant.outline;

  const CustomButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = AppSizes.buttonHeightMd,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = AppSizes.radiusMd,
  }) : variant = ButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveBgColor = backgroundColor ?? _getDefaultBackgroundColor(theme, isDark);
    final effectiveTextColor = textColor ?? _getDefaultTextColor(theme, isDark);

    final Widget content = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSizes.iconSm, color: effectiveTextColor),
                const SizedBox(width: AppSizes.p8),
              ],
              Text(
                text,
                style: AppTextStyles.button.copyWith(color: effectiveTextColor),
              ),
            ],
          );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBgColor,
      foregroundColor: effectiveTextColor,
      elevation: variant == ButtonVariant.primary ? 0 : 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: variant == ButtonVariant.outline
            ? BorderSide(
                color: textColor ?? theme.colorScheme.primary,
                width: 1.5,
              )
            : BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: isLoading ? null : onPressed,
        child: content,
      ),
    );
  }

  Color _getDefaultBackgroundColor(ThemeData theme, bool isDark) {
    switch (variant) {
      case ButtonVariant.primary:
        return theme.colorScheme.primary;
      case ButtonVariant.secondary:
        return isDark ? AppColors.grey800 : AppColors.grey200;
      case ButtonVariant.outline:
      case ButtonVariant.text:
        return Colors.transparent;
    }
  }

  Color _getDefaultTextColor(ThemeData theme, bool isDark) {
    switch (variant) {
      case ButtonVariant.primary:
        return Colors.white;
      case ButtonVariant.secondary:
        return isDark ? Colors.white : AppColors.grey900;
      case ButtonVariant.outline:
        return theme.colorScheme.primary;
      case ButtonVariant.text:
        return theme.colorScheme.primary;
    }
  }
}

