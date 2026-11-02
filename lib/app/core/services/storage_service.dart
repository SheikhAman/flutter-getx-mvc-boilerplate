import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();

  final GetStorage _box = GetStorage();

  static const String keyToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUser = 'user_data';
  static const String keyDarkMode = 'is_dark_mode';
  static const String keyLocale = 'app_locale';
  static const String keyOnboardingSeen = 'onboarding_seen';
  static const String keyRememberMe = 'remember_me';
  static const String keyPrimaryColorIndex = 'primary_color_index';

  static Future<StorageService> init() async {
    await GetStorage.init();
    return StorageService();
  }

  // Generic methods
  T? read<T>(String key, {T? defaultValue}) {
    return _box.read<T>(key) ?? defaultValue;
  }

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  bool hasData(String key) {
    return _box.hasData(key);
  }

  Future<void> clearAll() async {
    await _box.erase();
  }

  // Auth getters & setters
  String? get token => read<String>(keyToken);
  Future<void> setToken(String? value) async {
    if (value == null) {
      await remove(keyToken);
    } else {
      await write(keyToken, value);
    }
  }

  String? get refreshToken => read<String>(keyRefreshToken);
  Future<void> setRefreshToken(String? value) async {
    if (value == null) {
      await remove(keyRefreshToken);
    } else {
      await write(keyRefreshToken, value);
    }
  }

  bool get isLoggedIn => read<bool>(keyIsLoggedIn, defaultValue: false) ?? false;
  Future<void> setIsLoggedIn(bool value) async {
    await write(keyIsLoggedIn, value);
  }

  Map<String, dynamic>? get userData {
    final raw = read<dynamic>(keyUser);
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) return Map<String, dynamic>.from(raw);
    return null;
  }

  Future<void> setUserData(Map<String, dynamic>? data) async {
    if (data == null) {
      await remove(keyUser);
    } else {
      await write(keyUser, data);
    }
  }

  // App settings getters & setters
  bool get isDarkMode => read<bool>(keyDarkMode, defaultValue: false) ?? false;
  Future<void> setDarkMode(bool value) async {
    await write(keyDarkMode, value);
  }

  String get localeCode => read<String>(keyLocale, defaultValue: 'en_US') ?? 'en_US';
  Future<void> setLocaleCode(String code) async {
    await write(keyLocale, code);
  }

  bool get isOnboardingSeen => read<bool>(keyOnboardingSeen, defaultValue: false) ?? false;
  Future<void> setOnboardingSeen(bool value) async {
    await write(keyOnboardingSeen, value);
  }

  bool get isRememberMe => read<bool>(keyRememberMe, defaultValue: false) ?? false;
  Future<void> setRememberMe(bool value) async {
    await write(keyRememberMe, value);
  }

  int get primaryColorIndex => read<int>(keyPrimaryColorIndex, defaultValue: 0) ?? 0;
  Future<void> setPrimaryColorIndex(int index) async {
    await write(keyPrimaryColorIndex, index);
  }
}

