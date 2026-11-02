import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/post_model.dart';
import '../providers/search_provider.dart';

class AppSearchController extends GetxController {
  final SearchProvider provider;

  AppSearchController({SearchProvider? searchProvider})
      : provider = searchProvider ?? SearchProvider();

  final TextEditingController textEditingController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<PostModel> searchResults = <PostModel>[].obs;
  final RxBool hasSearched = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 400ms debounced search worker
    debounce(
      searchQuery,
      (query) => _executeSearch(query),
      time: const Duration(milliseconds: 400),
    );
  }

  void onQueryChanged(String query) {
    searchQuery.value = query.trim();
  }

  void clearSearch() {
    textEditingController.clear();
    searchQuery.value = '';
    searchResults.clear();
    hasSearched.value = false;
  }

  Future<void> _executeSearch(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      hasSearched.value = false;
      return;
    }

    try {
      isLoading.value = true;
      hasSearched.value = true;
      final results = await provider.searchPosts(query);
      searchResults.assignAll(results);
    } catch (_) {
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}

