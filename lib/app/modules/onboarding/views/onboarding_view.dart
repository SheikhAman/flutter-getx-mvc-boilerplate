import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page_item.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final pages = [
      OnboardingPageItem(
        icon: Icons.rocket_launch_rounded,
        title: AppStrings.onboarding1Title.tr,
        description: AppStrings.onboarding1Desc.tr,
      ),
      OnboardingPageItem(
        icon: Icons.hub_rounded,
        title: AppStrings.onboarding2Title.tr,
        description: AppStrings.onboarding2Desc.tr,
      ),
      OnboardingPageItem(
        icon: Icons.auto_awesome_rounded,
        title: AppStrings.onboarding3Title.tr,
        description: AppStrings.onboarding3Desc.tr,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: controller.completeOnboarding,
            child: Text(AppStrings.skip.tr),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.p24),
              child: Column(
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: AppSizes.p4),
                          width: controller.currentPage.value == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? theme.colorScheme.primary
                                : theme.colorScheme.primary.withAlpha(50),
                            borderRadius: AppSizes.borderRadiusFull,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.p32),
                  Obx(
                    () => CustomButton(
                      text: controller.currentPage.value == pages.length - 1
                          ? AppStrings.getStarted.tr
                          : AppStrings.continueText.tr,
                      onPressed: controller.nextPage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

