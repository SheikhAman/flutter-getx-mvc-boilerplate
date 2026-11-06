import 'package:get/get.dart';
import '../../../core/services/locale_service.dart';
import '../../../core/services/theme_controller.dart';

class SettingsController extends GetxController {
  final ThemeController themeController = ThemeController.to;
  final LocaleService localeService = LocaleService.to;

  bool get isDarkMode => themeController.isDarkMode.value;
  bool get isBengali => localeService.isBengali;
  int get primaryColorIndex => themeController.primaryColorIndex.value;

  void toggleTheme() {
    themeController.toggleTheme();
  }

  void toggleLanguage() {
    localeService.toggleLocale();
  }

  void selectColorSeed(int index) {
    themeController.setPrimaryColorIndex(index);
  }
}
