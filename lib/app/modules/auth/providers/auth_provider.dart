import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../../data/models/user_model.dart';

class AuthProvider {
  final DioClient _dioClient;

  AuthProvider({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  DioClient get client => _dioClient;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // In production, this calls _dioClient.post(ApiConstants.login, data: ...)
    // For our robust boilerplate, simulate network latency and return UserModel:
    await Future.delayed(const Duration(milliseconds: 600));

    return UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: email.split('@').first.capitalizeFirst ?? 'User',
      email: email,
      phone: '+1 555-0199',
      role: 'member',
      token: 'jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    return UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      role: 'member',
      token: 'jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );
  }

  Future<bool> verifyOtp({
    required String code,
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    // Validates against demo OTP
    return code.trim() == ApiConstants.demoOtp;
  }

  Future<bool> sendPasswordReset({
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true;
  }
}

extension on String {
  String? get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
