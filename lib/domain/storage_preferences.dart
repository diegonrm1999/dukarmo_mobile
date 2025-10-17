import 'package:dukarmo_app/domain/session.dart';
import 'package:dukarmo_app/enums/user_role.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoragePreferences {
  static const String tokenKey = "token";
  static const String roleKey = "role";
  static const String userIdKey = "userId";
  static const String nameKey = "name";
  static const String refreshTokenKey = "refreshToken";

  final FlutterSecureStorage _storage;
  StoragePreferences(this._storage);

  Future<void> saveCurrentSession(Session session) async {
    await _storage.write(key: tokenKey, value: session.token);
    await _storage.write(key: roleKey, value: session.role.name);
    await _storage.write(key: userIdKey, value: session.userId);
    await _storage.write(key: nameKey, value: session.name);
    await _storage.write(key: refreshTokenKey, value: session.refreshToken);
  }

  Future<Session?> getCurrentSession() async {
    final token = await _storage.read(key: tokenKey);
    final savedRole = await _storage.read(key: roleKey);
    final currentRole = UserRole.values.firstWhere(
      (role) => role.name == savedRole,
      orElse: () => UserRole.Unknown,
    );
    final userId = await _storage.read(key: userIdKey);
    final name = await _storage.read(key: nameKey);
    final refreshToken = await _storage.read(key: refreshTokenKey);

    if (token != null &&
        userId != null &&
        name != null &&
        refreshToken != null) {
      return Session(
        token: token,
        role: currentRole,
        userId: userId,
        name: name,
        refreshToken: refreshToken,
      );
    }
    return null;
  }

  Future<void> deleteCurrentSession() async {
    await _storage.delete(key: tokenKey);
    await _storage.delete(key: userIdKey);
    await _storage.delete(key: roleKey);
    await _storage.delete(key: nameKey);
    await _storage.delete(key: refreshTokenKey);
  }

  Future<void> updateToken(String newToken) async {
    await _storage.write(key: tokenKey, value: newToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: refreshTokenKey);
  }
}
