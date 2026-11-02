import '../../../core/network/dio_client.dart';
import '../../../data/models/user_model.dart';

class ProfileProvider {
  final DioClient _dioClient;

  ProfileProvider({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  DioClient get client => _dioClient;

  Future<UserModel> updateProfile({
    required String id,
    required String name,
    required String phone,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserModel(
      id: id,
      name: name,
      email: 'user@fluttercore.dev',
      phone: phone,
      role: 'member',
    );
  }
}
