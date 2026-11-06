import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../controllers/post_detail_controller.dart';

class PostDetailView extends GetView<PostDetailController> {
  const PostDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value && controller.post.value == null) {
          return const LoadingView(message: 'Loading post details...');
        }

        if (controller.errorMessage.value.isNotEmpty &&
            controller.post.value == null) {
          return EmptyStateView.error(
            title: AppStrings.error.tr,
            subtitle: controller.errorMessage.value,
            onAction: () => controller.fetchPostDetail(1),
          );
        }

        final post = controller.post.value;
        if (post == null) {
          return EmptyStateView(
            title: AppStrings.noPostsFound.tr,
          );
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 180.0,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: AppSizes.iconSm),
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    controller.isLiked.value
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: controller.isLiked.value ? Colors.red : null,
                  ),
                  onPressed: controller.toggleLike,
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Post #${post.id}',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withAlpha(160),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.article_rounded,
                      size: 64,
                      color: Colors.white.withAlpha(80),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Author Row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor:
                              theme.colorScheme.primary.withAlpha(30),
                          child: Text(
                            '#${post.userId}',
                            style: AppTextStyles.titleMedium.copyWith(
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
                                Formatters.formatDateTime(post.createdAt),
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.p12,
                            vertical: AppSizes.p6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withAlpha(20),
                            borderRadius: AppSizes.borderRadiusFull,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite_rounded,
                                size: 14,
                                color: controller.isLiked.value
                                    ? Colors.red
                                    : theme.colorScheme.primary,
                              ),
                              const SizedBox(width: AppSizes.p4),
                              Text(
                                '${controller.likesCount.value}',
                                style: AppTextStyles.caption.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.p24),

                    // Post Title with Hero
                    Hero(
                      tag: 'post_title_${post.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          Formatters.capitalize(post.title),
                          style: AppTextStyles.h2,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.p16),

                    // Body
                    Text(
                      post.body,
                      style: AppTextStyles.bodyLarge.copyWith(
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: AppSizes.p32),

                    const Divider(),
                    const SizedBox(height: AppSizes.p16),

                    // Comments Title
                    Row(
                      children: [
                        const Icon(Icons.mode_comment_outlined, size: 20),
                        const SizedBox(width: AppSizes.p8),
                        Text(
                          'Comments (${controller.comments.length})',
                          style: AppTextStyles.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.p16),
                  ],
                ),
              ),
            ),
            // Comments SliverList
            if (controller.comments.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.p20),
                  child: Text('No comments yet.', style: AppTextStyles.caption),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final comment = controller.comments[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppSizes.p20,
                        vertical: AppSizes.p6,
                      ),
                      padding: const EdgeInsets.all(AppSizes.p16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFFF9FAFB),
                        borderRadius: AppSizes.borderRadiusMd,
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF2E2E2E)
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor:
                                    theme.colorScheme.primary.withAlpha(25),
                                child: Text(
                                  (comment['name'] as String? ?? 'U')[0]
                                      .toUpperCase(),
                                  style: AppTextStyles.titleSmall.copyWith(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSizes.p8),
                              Expanded(
                                child: Text(
                                  comment['email']?.toString() ?? '',
                                  style: AppTextStyles.label,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.p8),
                          Text(
                            Formatters.capitalize(
                                comment['name']?.toString() ?? ''),
                            style: AppTextStyles.titleMedium,
                          ),
                          const SizedBox(height: AppSizes.p4),
                          Text(
                            comment['body']?.toString() ?? '',
                            style: AppTextStyles.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: controller.comments.length,
                ),
              ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSizes.p40),
            ),
          ],
        );
      }),
    );
  }
}
