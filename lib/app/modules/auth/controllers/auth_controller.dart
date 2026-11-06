import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../../core/values/app_strings.dart';
import '../../../data/models/user_model.dart';
import '../providers/auth_provider.dart';

class AuthController extends GetxController {
  final AuthProvider provider;

  AuthController({AuthProvider? authProvider})
      : provider = authProvider ?? AuthProvider();

  final RxBool isLoading = false.obs;
  final RxBool isOtpVerifying = false.obs;
  final RxString pendingEmail = ''.obs;
  final RxString pendingPhone = ''.obs;
  final Rxn<UserModel> pendingUser = Rxn<UserModel>();
  final RxBool rememberMe = false.obs;

  // Controllers for Login
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Controllers for Register
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  // Controllers for OTP & Forgot Password
  final otpController = TextEditingController();
  final forgotPasswordEmailController = TextEditingController();

  // OTP Timer
  Timer? _timer;
  final RxInt timerSeconds = 30.obs;
  final RxBool canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    rememberMe.value = StorageService.to.isRememberMe;
  }

  void startResendTimer() {
    canResend.value = false;
    timerSeconds.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> login() async {
    final email = loginEmailController.text.trim();
    final password = loginPasswordController.text;

    try {
      isLoading.value = true;
      AppSnackbar.showLoading();

      final user = await provider.login(email: email, password: password);
      pendingUser.value = user;
      pendingEmail.value = email;

      await StorageService.to.setRememberMe(rememberMe.value);
      AppSnackbar.dismissLoading();
      AppSnackbar.showInfo(AppStrings.demoOtpHint.tr);

      startResendTimer();
      Get.toNamed(
        AppRoutes.otp,
        arguments: {'email': email, 'user': user},
      );
    } catch (e) {
      AppSnackbar.dismissLoading();
      AppSnackbar.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    final name = registerNameController.text.trim();
    final email = registerEmailController.text.trim();
    final phone = registerPhoneController.text.trim();
    final password = registerPasswordController.text;

    try {
      isLoading.value = true;
      AppSnackbar.showLoading();

      final user = await provider.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      pendingUser.value = user;
      pendingEmail.value = email;
      pendingPhone.value = phone;

      AppSnackbar.dismissLoading();
      AppSnackbar.showInfo(AppStrings.demoOtpHint.tr);

      startResendTimer();
      Get.toNamed(
        AppRoutes.otp,
        arguments: {'email': email, 'phone': phone, 'user': user},
      );
    } catch (e) {
      AppSnackbar.dismissLoading();
      AppSnackbar.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyOtp(String code) async {
    try {
      isOtpVerifying.value = true;
      AppSnackbar.showLoading();

      final isValid = await provider.verifyOtp(
        code: code,
        email: pendingEmail.value,
      );

      AppSnackbar.dismissLoading();

      if (!isValid) {
        AppSnackbar.showError(
            'Invalid code. Use ${ApiConstants.demoOtp} for demo.');
        return false;
      }

      final user = pendingUser.value ??
          UserModel(
            id: 'usr_demo',
            name: 'Demo User',
            email: pendingEmail.value.isNotEmpty
                ? pendingEmail.value
                : 'demo@fluttercore.dev',
            phone: pendingPhone.value,
            role: 'member',
          );

      await AuthService.to.saveAuth(
        user: user,
        authToken: 'jwt_auth_${DateTime.now().millisecondsSinceEpoch}',
      );

      AppSnackbar.showSuccess(AppStrings.success.tr);
      Get.offAllNamed(AppRoutes.dashboard);
      return true;
    } catch (e) {
      AppSnackbar.dismissLoading();
      AppSnackbar.showError(e.toString());
      return false;
    } finally {
      isOtpVerifying.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;
    startResendTimer();
    AppSnackbar.showInfo(AppStrings.demoOtpHint.tr);
  }

  Future<void> sendPasswordReset() async {
    final email = forgotPasswordEmailController.text.trim();
    try {
      isLoading.value = true;
      AppSnackbar.showLoading();

      await provider.sendPasswordReset(email: email);
      AppSnackbar.dismissLoading();
      AppSnackbar.showSuccess('Reset instructions sent to $email');
      Get.back();
    } catch (e) {
      AppSnackbar.dismissLoading();
      AppSnackbar.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPhoneController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    otpController.dispose();
    forgotPasswordEmailController.dispose();
    super.onClose();
  }
}
