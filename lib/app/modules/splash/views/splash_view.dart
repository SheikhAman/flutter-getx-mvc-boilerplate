import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller; // Ensures controller is instantiated
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: AppSizes.borderRadiusXl,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withAlpha(50),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: AppSizes.borderRadiusXl,
                child: Image.asset(
                  AppAssets.logo,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.flutter_dash,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.p24),
            Text(
              AppStrings.appName.tr,
              style: AppTextStyles.h1.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppSizes.p8),
            Text(
              'Enterprise-Grade Boilerplate',
              style: AppTextStyles.bodyMedium.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withAlpha(160),
              ),
            ),
            const SizedBox(height: AppSizes.p48),
            SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

