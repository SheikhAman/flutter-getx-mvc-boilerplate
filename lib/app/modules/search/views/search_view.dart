import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../home/widgets/post_card.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<AppSearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: false,
        titleWidget: Container(
          height: 42,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: AppSizes.borderRadiusMd,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: TextField(
            controller: controller.textEditingController,
            onChanged: controller.onQueryChanged,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
            decoration: InputDecoration(
              hintText: AppStrings.searchHint.tr,
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              prefixIcon:
                  const Icon(Icons.search_rounded, size: AppSizes.iconSm),
              suffixIcon: Obx(
                () => controller.searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded,
                            size: AppSizes.iconSm),
                        onPressed: controller.clearSearch,
                      )
                    : const SizedBox.shrink(),
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.p12,
                vertical: AppSizes.p10,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingView(message: 'Searching...');
        }

        if (!controller.hasSearched.value) {
          return EmptyStateView(
            icon: Icons.search_rounded,
            title: AppStrings.search.tr,
            subtitle: AppStrings.typeToSearch.tr,
          );
        }

        if (controller.searchResults.isEmpty) {
          return EmptyStateView(
            icon: Icons.find_in_page_outlined,
            title: AppStrings.noResults.tr,
            subtitle: 'No results found for "${controller.searchQuery.value}"',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.p12),
          itemCount: controller.searchResults.length,
          itemBuilder: (context, index) {
            return PostCard(post: controller.searchResults[index]);
          },
        );
      }),
    );
  }
}
