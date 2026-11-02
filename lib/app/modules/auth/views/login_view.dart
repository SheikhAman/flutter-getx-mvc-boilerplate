import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.p24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_person_rounded,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: AppSizes.p20),
                  Text(
                    AppStrings.welcome.tr,
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.p8),
                  Text(
                    AppStrings.welcomeSubtitle.tr,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withAlpha(160),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.p32),

                  // Email Field
                  CustomTextField(
                    controller: controller.loginEmailController,
                    label: AppStrings.email.tr,
                    hint: 'user@example.com',
                    prefixIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: AppSizes.p16),

                  // Password Field
                  CustomTextField(
                    controller: controller.loginPasswordController,
                    label: AppStrings.password.tr,
                    hint: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    isPassword: true,
                    validator: (v) => Validators.password(v, minLength: 6),
                  ),
                  const SizedBox(height: AppSizes.p12),

                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.rememberMe.value,
                              onChanged: (val) {
                                controller.rememberMe.value = val ?? false;
                              },
                            ),
                          ),
                          Text(
                            AppStrings.rememberMe.tr,
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                        child: Text(
                          AppStrings.forgotPassword.tr,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.p24),

                  // Submit Button
                  Obx(
                    () => CustomButton(
                      text: AppStrings.login.tr,
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          controller.login();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: AppSizes.p24),

                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAccount.tr,
                        style: AppTextStyles.bodySmall,
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.register),
                        child: Text(
                          AppStrings.register.tr,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.p16),

                  // Explore as Guest / Go to Dashboard
                  CustomButton.outline(
                    text: 'Explore Component Gallery',
                    icon: Icons.dashboard_customize_outlined,
                    onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

