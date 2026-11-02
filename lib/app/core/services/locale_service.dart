import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'storage_service.dart';

class LocaleService extends GetxService {
  static LocaleService get to => Get.find();

  final StorageService _storage = StorageService.to;

  final Rx<Locale> currentLocale = const Locale('en', 'US').obs;

  static const Locale englishLocale = Locale('en', 'US');
  static const Locale bengaliLocale = Locale('bn', 'BD');

  @override
  void onInit() {
    super.onInit();
    _loadLocale();
  }

  void _loadLocale() {
    final savedCode = _storage.localeCode;
    if (savedCode == 'bn_BD') {
      currentLocale.value = bengaliLocale;
    } else {
      currentLocale.value = englishLocale;
    }
  }

  bool get isEnglish => currentLocale.value.languageCode == 'en';
  bool get isBengali => currentLocale.value.languageCode == 'bn';

  Future<void> changeLocale(Locale locale) async {
    currentLocale.value = locale;
    final code = '${locale.languageCode}_${locale.countryCode ?? ''}';
    await _storage.setLocaleCode(code);
    await Get.updateLocale(locale);
  }

  Future<void> toggleLocale() async {
    if (isEnglish) {
      await changeLocale(bengaliLocale);
    } else {
      await changeLocale(englishLocale);
    }
  }
}

