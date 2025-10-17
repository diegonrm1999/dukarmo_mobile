import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/session.dart';
import 'package:dukarmo_app/managers/login_manager.dart';
import 'package:dukarmo_app/services/session_service.dart';

class AuthService {
  final _loginManager = getSingleton<LoginManager>();
  final _sessionService = getSingleton<SessionService>();

  Future<Session> login(String email, String password) async {
    try {
      final session = await _loginManager.login(email, password);
      await _sessionService.saveSession(session);
      return session;
    } catch (e) {
      throw Exception('Error al iniciar sesión');
    }
  }
}
