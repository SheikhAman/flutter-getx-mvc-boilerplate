import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../controllers/home_controller.dart';
import '../widgets/post_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  void _showCreatePostSheet(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(AppSizes.p24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXl),
          ),
        ),
        child: SingleChildScrollView(
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
              Text(
                AppStrings.createPost.tr,
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: AppSizes.p20),
              CustomTextField(
                controller: titleController,
                label: AppStrings.postTitle.tr,
                hint: 'Enter title...',
              ),
              const SizedBox(height: AppSizes.p16),
              CustomTextField(
                controller: bodyController,
                label: AppStrings.postBody.tr,
                hint: 'Enter content...',
                maxLines: 4,
              ),
              const SizedBox(height: AppSizes.p24),
              Obx(
                () => CustomButton(
                  text: AppStrings.submit.tr,
                  isLoading: controller.isSubmitting.value,
                  onPressed: controller.isSubmitting.value
                      ? null
                      : () {
                          if (titleController.text.trim().isEmpty) return;
                          controller.createPost(
                            titleController.text.trim(),
                            bodyController.text.trim(),
                          );
                        },
                ),
              ),
              const SizedBox(height: AppSizes.p12),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: false,
        centerTitle: false,
        titleWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.logo,
              height: 28,
              width: 28,
            ),
            const SizedBox(width: AppSizes.p10),
            Text(
              AppStrings.appName.tr,
              style: AppTextStyles.h4.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: AppStrings.createPost.tr,
            onPressed: () => _showCreatePostSheet(context),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const ShimmerListLoading();
        }

        if (controller.errorMessage.value.isNotEmpty &&
            controller.posts.isEmpty) {
          return EmptyStateView.error(
            title: AppStrings.error.tr,
            subtitle: controller.errorMessage.value,
            onAction: () => controller.fetchPosts(isRefresh: true),
          );
        }

        if (controller.posts.isEmpty) {
          return EmptyStateView(
            title: AppStrings.noPostsFound.tr,
            subtitle: AppStrings.emptySub.tr,
            actionText: AppStrings.retry.tr,
            onAction: () => controller.fetchPosts(isRefresh: true),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchPosts(isRefresh: true),
          child: ListView.builder(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount:
                controller.posts.length + (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.posts.length) {
                return PostCard(post: controller.posts[index]);
              }

              // Pagination loader at bottom
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.p20),
                child: Center(
                  child: controller.isLoadingMore.value
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const SizedBox.shrink(),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
