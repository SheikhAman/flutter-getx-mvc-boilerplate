import 'package:flutter/material.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_text_styles.dart';

class OnboardingPageItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingPageItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.p32),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 88,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSizes.p40),
          Text(
            title,
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.p16),
          Text(
            description,
            style: AppTextStyles.bodyLarge.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withAlpha(180),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
