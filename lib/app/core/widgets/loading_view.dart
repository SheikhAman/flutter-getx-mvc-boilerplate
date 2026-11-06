import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../values/app_colors.dart';
import '../values/app_sizes.dart';

class LoadingView extends StatelessWidget {
  final String? message;
  final Color? color;

  const LoadingView({
    super.key,
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? theme.colorScheme.primary,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppSizes.p16),
            Text(
              message!,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}

class ShimmerSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppSizes.radiusSm,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor:
          isDark ? AppColors.shimmerBaseDark : AppColors.shimmerBaseLight,
      highlightColor: isDark
          ? AppColors.shimmerHighlightDark
          : AppColors.shimmerHighlightLight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColors.grey800 : Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class ShimmerListLoading extends StatelessWidget {
  final int itemCount;
  final double itemHeight;

  const ShimmerListLoading({
    super.key,
    this.itemCount = 6,
    this.itemHeight = 96.0,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSizes.p16),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: AppSizes.p12),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(AppSizes.p16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: AppSizes.borderRadiusMd,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const ShimmerSkeleton(
                      width: 40, height: 40, borderRadius: AppSizes.radiusFull),
                  const SizedBox(width: AppSizes.p12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerSkeleton(width: 120, height: 14),
                        SizedBox(height: AppSizes.p6),
                        ShimmerSkeleton(width: 80, height: 10),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.p16),
              const ShimmerSkeleton(width: double.infinity, height: 16),
              const SizedBox(height: AppSizes.p8),
              const ShimmerSkeleton(width: 220, height: 12),
            ],
          ),
        );
      },
    );
  }
}
