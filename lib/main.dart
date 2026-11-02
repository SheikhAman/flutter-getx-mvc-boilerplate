import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/core/network/network_info.dart';
import 'app/core/routes/app_pages.dart';
import 'app/core/routes/app_routes.dart';
import 'app/core/services/auth_service.dart';
import 'app/core/services/locale_service.dart';
import 'app/core/services/storage_service.dart';
import 'app/core/services/theme_controller.dart';
import 'app/core/values/app_strings.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize permanent services
  await StorageService.init();
  Get.put(StorageService(), permanent: true);
  Get.put(AuthService(), permanent: true);
  Get.put(LocaleService(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  Get.put(NetworkInfo(), permanent: true);

  _configEasyLoading();

  runApp(const FlutterCoreApp());
}

void _configEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 2)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..radius = 12
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false;
}

class FlutterCoreApp extends StatelessWidget {
  const FlutterCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.to;
    final localeService = LocaleService.to;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            title: 'Flutter Core',
            debugShowCheckedModeBanner: false,
            translations: AppStrings(),
            locale: localeService.currentLocale.value,
            fallbackLocale: LocaleService.englishLocale,
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 300),
            theme: themeController.lightTheme,
            darkTheme: themeController.darkTheme,
            themeMode: themeController.themeMode,
            initialRoute: AppRoutes.initial,
            getPages: AppPages.routes,
            unknownRoute: AppPages.unknownRoute,
            builder: EasyLoading.init(
              builder: (context, widget) {
                return GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: widget ?? const SizedBox(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
