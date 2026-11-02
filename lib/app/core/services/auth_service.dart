import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../routes/app_routes.dart';
import 'storage_service.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final StorageService _storage = StorageService.to;

  final RxBool isLoggedIn = false.obs;
  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxString token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAuthFromStorage();
  }

  void _loadAuthFromStorage() {
    final savedToken = _storage.token;
    final isAuth = _storage.isLoggedIn;
    final userData = _storage.userData;

    if (savedToken != null && savedToken.isNotEmpty && isAuth) {
      token.value = savedToken;
      isLoggedIn.value = true;
      if (userData != null) {
        currentUser.value = UserModel.fromJson(userData);
      }
    } else {
      isLoggedIn.value = false;
      token.value = '';
      currentUser.value = null;
    }
  }

  Future<void> saveAuth({
    required UserModel user,
    required String authToken,
    String? refreshToken,
  }) async {
    token.value = authToken;
    currentUser.value = user;
    isLoggedIn.value = true;

    await _storage.setToken(authToken);
    if (refreshToken != null) {
      await _storage.setRefreshToken(refreshToken);
    }
    await _storage.setIsLoggedIn(true);
    await _storage.setUserData(user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    currentUser.value = user;
    await _storage.setUserData(user.toJson());
  }

  Future<void> logout() async {
    isLoggedIn.value = false;
    token.value = '';
    currentUser.value = null;

    await _storage.setToken(null);
    await _storage.setRefreshToken(null);
    await _storage.setIsLoggedIn(false);
    await _storage.setUserData(null);

    Get.offAllNamed(AppRoutes.login);
  }
}

