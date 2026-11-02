class AppRoutes {
  AppRoutes._();

  static const String initial = '/';
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';

  // Core App & Dashboard
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String postDetail = '/posts/detail';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String showcase = '/showcase';

  // Common
  static const String noInternet = '/no-internet';
  static const String webview = '/webview';
  static const String unknownRoute = '/404';
}

