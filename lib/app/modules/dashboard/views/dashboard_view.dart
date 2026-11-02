import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_strings.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../search/views/search_view.dart';
import '../../showcase/views/showcase_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const List<Widget> tabs = [
      HomeView(),
      SearchView(),
      ShowcaseView(),
      ProfileView(),
    ];

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: tabs,
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeTabIndex,
          indicatorColor: theme.colorScheme.primary.withAlpha(40),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded, color: theme.colorScheme.primary),
              label: AppStrings.home.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search_rounded, color: theme.colorScheme.primary),
              label: AppStrings.search.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.palette_outlined),
              selectedIcon: Icon(Icons.palette_rounded, color: theme.colorScheme.primary),
              label: AppStrings.showcase.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded, color: theme.colorScheme.primary),
              label: AppStrings.profile.tr,
            ),
          ],
        ),
      ),
    );
  }
}

