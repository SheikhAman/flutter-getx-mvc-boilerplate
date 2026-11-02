import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/widgets/empty_state_view.dart';

class UnknownRouteView extends StatelessWidget {
  const UnknownRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: EmptyStateView(
          icon: Icons.search_off_rounded,
          title: AppStrings.notFoundTitle.tr,
          subtitle: AppStrings.notFoundSub.tr,
          actionText: AppStrings.backToHome.tr,
          onAction: () => Get.offAllNamed(AppRoutes.dashboard),
        ),
      ),
    );
  }
}

