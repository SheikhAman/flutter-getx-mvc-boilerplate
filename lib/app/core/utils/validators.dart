import 'package:get/get.dart';
import '../values/app_strings.dart';

class Validators {
  Validators._();

  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? AppStrings.fieldRequired.tr;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired.tr;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.invalidEmail.tr;
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired.tr;
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s-]'), ''))) {
      return AppStrings.invalidPhone.tr;
    }
    return null;
  }

  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired.tr;
    }
    if (value.length < minLength) {
      return AppStrings.passwordTooShort.tr;
    }
    return null;
  }

  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired.tr;
    }
    if (value != originalPassword) {
      return AppStrings.passwordsDoNotMatch.tr;
    }
    return null;
  }

  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired.tr;
    }
    if (value.trim().length != length) {
      return AppStrings.invalidOtp.tr;
    }
    return null;
  }
}

