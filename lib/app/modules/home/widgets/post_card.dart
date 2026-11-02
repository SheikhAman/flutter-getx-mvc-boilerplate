import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.p16,
        vertical: AppSizes.p6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppSizes.borderRadiusMd,
        side: BorderSide(
          color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE5E7EB),
        ),
      ),
      child: InkWell(
        borderRadius: AppSizes.borderRadiusMd,
        onTap: () {
          Get.toNamed(
            AppRoutes.postDetail,
            arguments: post,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: theme.colorScheme.primary.withAlpha(30),
                    child: Text(
                      '#${post.userId}',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.p12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.authorName ?? 'Author #${post.userId}',
                          style: AppTextStyles.titleMedium,
                        ),
                        Text(
                          Formatters.timeAgo(post.createdAt),
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: isDark ? Colors.white38 : Colors.black26,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.p12),
              Hero(
                tag: 'post_title_${post.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    Formatters.capitalize(post.title),
                    style: AppTextStyles.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.p8),
              Text(
                post.body,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withAlpha(180),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSizes.p12),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_alt_outlined,
                    size: AppSizes.iconXs,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: AppSizes.p4),
                  Text(
                    '${post.likesCount} likes',
                    style: AppTextStyles.caption.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'ID: ${post.id}',
                    style: AppTextStyles.caption,
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

