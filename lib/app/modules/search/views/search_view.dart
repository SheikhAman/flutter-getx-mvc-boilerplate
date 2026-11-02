import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../home/widgets/post_card.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<AppSearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.search.tr),
      ),
      body: Column(
        children: [
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.all(AppSizes.p16),
            child: TextField(
              controller: controller.textEditingController,
              onChanged: controller.onQueryChanged,
              decoration: InputDecoration(
                hintText: AppStrings.searchHint.tr,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: Obx(
                  () => controller.searchQuery.value.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: AppSizes.iconSm),
                          onPressed: controller.clearSearch,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),

          // Search Content
          Expanded(
            child: Obx(() {
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
                padding: const EdgeInsets.only(bottom: AppSizes.p24),
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  return PostCard(post: controller.searchResults[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
