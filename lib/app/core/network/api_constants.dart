class ApiConstants {
  ApiConstants._();

  // Base URL
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Endpoints
  static const String posts = '/posts';
  static const String postById = '/posts/{id}';
  static const String users = '/users';
  static const String userById = '/users/{id}';
  static const String comments = '/comments';
  static const String photos = '/photos';

  // Demo Auth Endpoints
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyOtp = '/verify-otp';
  static const String refreshToken = '/refresh-token';

  // Demo Dummy Data
  static const String demoOtp = '112345';
}
