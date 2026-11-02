import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../../data/models/post_model.dart';
import '../providers/home_provider.dart';

class HomeController extends GetxController {
  final HomeProvider provider;

  HomeController({HomeProvider? homeProvider})
      : provider = homeProvider ?? HomeProvider();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxString errorMessage = ''.obs;
  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxInt currentPage = 1.obs;

  final ScrollController scrollController = ScrollController();
  final int pageLimit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading.value &&
          !isLoadingMore.value &&
          hasMore.value) {
        loadMore();
      }
    });
  }

  Future<void> fetchPosts({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage.value = 1;
      hasMore.value = true;
    }

    if (posts.isEmpty || isRefresh) {
      isLoading.value = true;
    }
    errorMessage.value = '';

    try {
      final result = await provider.getPosts(
        page: currentPage.value,
        limit: pageLimit,
      );

      if (isRefresh) {
        posts.assignAll(result);
      } else {
        posts.addAll(result);
      }

      if (result.length < pageLimit) {
        hasMore.value = false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore.value) return;

    isLoadingMore.value = true;
    currentPage.value++;

    try {
      final nextItems = await provider.getPosts(
        page: currentPage.value,
        limit: pageLimit,
      );

      if (nextItems.isEmpty) {
        hasMore.value = false;
      } else {
        posts.addAll(nextItems);
        if (nextItems.length < pageLimit) {
          hasMore.value = false;
        }
      }
    } catch (e) {
      // Revert page counter on error
      currentPage.value--;
      AppSnackbar.showError(e.toString());
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<bool> createPost(String title, String body) async {
    try {
      AppSnackbar.showLoading();
      final newPost = await provider.createPost(title: title, body: body);
      posts.insert(0, newPost);
      AppSnackbar.dismissLoading();
      AppSnackbar.showSuccess('Post created successfully!');
      return true;
    } catch (e) {
      AppSnackbar.dismissLoading();
      AppSnackbar.showError(e.toString());
      return false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
