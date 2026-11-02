import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/validators.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.register.tr,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create an Account',
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: AppSizes.p8),
                Text(
                  'Join flutter_core boilerplate community',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withAlpha(160),
                  ),
                ),
                const SizedBox(height: AppSizes.p28),

                // Name Field
                CustomTextField(
                  controller: controller.registerNameController,
                  label: AppStrings.name.tr,
                  hint: 'John Doe',
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  validator: Validators.required,
                ),
                const SizedBox(height: AppSizes.p16),

                // Email Field
                CustomTextField(
                  controller: controller.registerEmailController,
                  label: AppStrings.email.tr,
                  hint: 'user@example.com',
                  prefixIcon: const Icon(Icons.email_outlined),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                const SizedBox(height: AppSizes.p16),

                // Phone Field
                CustomTextField(
                  controller: controller.registerPhoneController,
                  label: AppStrings.phone.tr,
                  hint: '+1 555-0199',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  keyboardType: TextInputType.phone,
                  validator: Validators.phone,
                ),
                const SizedBox(height: AppSizes.p16),

                // Password Field
                CustomTextField(
                  controller: controller.registerPasswordController,
                  label: AppStrings.password.tr,
                  hint: '••••••••',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  isPassword: true,
                  validator: (v) => Validators.password(v, minLength: 6),
                ),
                const SizedBox(height: AppSizes.p16),

                // Confirm Password Field
                CustomTextField(
                  controller: controller.registerConfirmPasswordController,
                  label: AppStrings.confirmPassword.tr,
                  hint: '••••••••',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  isPassword: true,
                  validator: (v) => Validators.confirmPassword(
                    v,
                    controller.registerPasswordController.text,
                  ),
                ),
                const SizedBox(height: AppSizes.p28),

                // Submit Button
                Obx(
                  () => CustomButton(
                    text: AppStrings.register.tr,
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        controller.register();
                      }
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.p20),

                // Already Have Account Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount.tr,
                      style: AppTextStyles.bodySmall,
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        AppStrings.login.tr,
                        style: AppTextStyles.titleSmall.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
