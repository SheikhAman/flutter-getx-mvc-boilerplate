import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../controllers/common_controller.dart';

class NoInternetView extends GetView<CommonController> {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: EmptyStateView.error(
          icon: Icons.wifi_off_rounded,
          title: AppStrings.networkError.tr,
          subtitle: AppStrings.networkErrorSub.tr,
          actionText: AppStrings.retry.tr,
          onAction: controller.retryConnection,
        ),
      ),
    );
  }
}
