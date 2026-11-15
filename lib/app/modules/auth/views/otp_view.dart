import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/auth_controller.dart';

class OtpView extends GetView<AuthController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final email = Get.arguments is Map && Get.arguments['email'] != null
        ? Get.arguments['email'] as String
        : (controller.pendingEmail.value.isNotEmpty
            ? controller.pendingEmail.value
            : 'demo@fluttercore.dev');

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.otpTitle.tr,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSizes.p16),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mark_email_read_outlined,
                  size: 38,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppSizes.p24),
              Text(
                AppStrings.otpTitle.tr,
                style: AppTextStyles.h2,
              ),
              const SizedBox(height: AppSizes.p8),
              Text(
                '${AppStrings.otpSent.tr}\n$email',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withAlpha(160),
                ),
              ),
              const SizedBox(height: AppSizes.p16),
              InkWell(
                onTap: controller.fillDemoOtp,
                borderRadius: AppSizes.borderRadiusMd,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.p16,
                    vertical: AppSizes.p8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(20),
                    borderRadius: AppSizes.borderRadiusMd,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.touch_app_outlined,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: AppSizes.p6),
                      Text(
                        'Demo OTP: ${ApiConstants.demoOtp} (Tap to auto-fill)',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.p32),

              // Pin Code Input
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.otpFocusNode.requestFocus();
                  SystemChannels.textInput.invokeMethod('TextInput.show');
                },
                child: PinCodeTextField(
                  key: const ValueKey('otp_pin_code_field'),
                  appContext: context,
                  length: 6,
                  autoFocus: true,
                  autoUnfocus: false,
                  autoDismissKeyboard: false,
                  focusNode: controller.otpFocusNode,
                  autoDisposeControllers: false,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  cursorColor: theme.colorScheme.primary,
                  textStyle: AppTextStyles.h3.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: AppSizes.borderRadiusMd,
                    fieldHeight: 52,
                    fieldWidth: 44,
                    activeFillColor:
                        isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    inactiveFillColor: isDark
                        ? const Color(0xFF1E1E1E)
                        : const Color(0xFFF9FAFB),
                    selectedFillColor:
                        isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    activeColor: theme.colorScheme.primary,
                    inactiveColor: isDark
                        ? const Color(0xFF374151)
                        : const Color(0xFFE5E7EB),
                    selectedColor: theme.colorScheme.primary,
                    borderWidth: 1.5,
                  ),
                  animationDuration: const Duration(milliseconds: 250),
                  enableActiveFill: true,
                  controller: controller.otpController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.show');
                  },
                  onCompleted: (code) {
                    controller.verifyOtp(code);
                  },
                  onChanged: (value) {
                    controller.otpCode.value = value;
                  },
                ),
              ),
              const SizedBox(height: AppSizes.p24),

              // Verify Button
              Obx(
                () => CustomButton(
                  text: AppStrings.verify.tr,
                  isLoading: controller.isOtpVerifying.value,
                  onPressed: () {
                    final code = controller.otpController.text.trim();
                    if (code.length == 6) {
                      controller.verifyOtp(code);
                    } else {
                      AppSnackbar.showWarning(
                        'Please enter the 6-digit verification code',
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: AppSizes.p24),

              // Resend Section
              Obx(
                () => controller.canResend.value
                    ? TextButton(
                        onPressed: controller.resendOtp,
                        child: Text(
                          AppStrings.resend.tr,
                          style: AppTextStyles.button.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSizes.p6),
                          Text(
                            'Resend code in ${controller.timerSeconds.value}s',
                            style: AppTextStyles.caption.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
