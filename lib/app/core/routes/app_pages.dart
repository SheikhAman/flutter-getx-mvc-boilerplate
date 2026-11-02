import 'package:get/get.dart';
import '../../modules/auth/bindings/auth_binding.dart';
import '../../modules/auth/views/forgot_password_view.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/auth/views/otp_view.dart';
import '../../modules/auth/views/register_view.dart';
import '../../modules/common/bindings/common_binding.dart';
import '../../modules/common/views/no_internet_view.dart';
import '../../modules/common/views/unknown_route_view.dart';
import '../../modules/common/views/webview_view.dart';
import '../../modules/dashboard/bindings/dashboard_binding.dart';
import '../../modules/dashboard/views/dashboard_view.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/onboarding/bindings/onboarding_binding.dart';
import '../../modules/onboarding/views/onboarding_view.dart';
import '../../modules/post_detail/bindings/post_detail_binding.dart';
import '../../modules/post_detail/views/post_detail_view.dart';
import '../../modules/profile/bindings/profile_binding.dart';
import '../../modules/profile/views/profile_view.dart';
import '../../modules/search/bindings/search_binding.dart';
import '../../modules/search/views/search_view.dart';
import '../../modules/settings/bindings/settings_binding.dart';
import '../../modules/settings/views/settings_view.dart';
import '../../modules/showcase/bindings/showcase_binding.dart';
import '../../modules/showcase/views/showcase_view.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.initial;

  static final unknownRoute = GetPage(
    name: AppRoutes.unknownRoute,
    page: () => const UnknownRouteView(),
  );

  static final routes = [
    // Splash & Onboarding
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
    ),

    // Auth
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    // Dashboard & Features
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.postDetail,
      page: () => const PostDetailView(),
      binding: PostDetailBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.showcase,
      page: () => const ShowcaseView(),
      binding: ShowcaseBinding(),
      transition: Transition.cupertino,
    ),

    // Common
    GetPage(
      name: AppRoutes.noInternet,
      page: () => const NoInternetView(),
      binding: CommonBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.webview,
      page: () => const WebViewScreen(),
      binding: CommonBinding(),
      transition: Transition.cupertino,
    ),
  ];
}

