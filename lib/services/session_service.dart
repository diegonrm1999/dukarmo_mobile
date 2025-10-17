import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/session.dart';
import 'package:dukarmo_app/domain/storage_preferences.dart';
import 'package:dukarmo_app/enums/user_role.dart';

class SessionService {
  final _storagPreferences = getSingleton<StoragePreferences>();
  Session? _currentSession;

  Session? get currentSession => _currentSession;

  UserRole? getRole() {
    return _currentSession?.role;
  }

  String? get userId => _currentSession?.userId;

  bool isLoggedIn() {
    return currentSession != null;
  }

  Future<void> saveSession(Session session) async {
    await _storagPreferences.saveCurrentSession(session);
    _currentSession = session;
  }

  void _setCurrentSession(Session? session) {
    _currentSession = session;
  }

  Future<void> deleteToken() async {
    _setCurrentSession(null);
    await _storagPreferences.deleteCurrentSession();
  }

  Future<void> bootstrapSessionFromStorage() async {
    var currentSession = await _storagPreferences.getCurrentSession();
    if (currentSession == null) {
      return;
    }
    if (currentSession.role != UserRole.Unknown) {
      _currentSession = currentSession;
    }
  }

  Future<void> updateToken(String newToken) async {
    await _storagPreferences.updateToken(newToken);
    if (_currentSession != null) {
      _currentSession = _currentSession!.copyWith(token: newToken);
    }
  }

  Future<String?> getRefreshToken() async {
    return await _storagPreferences.getRefreshToken();
  }
}
