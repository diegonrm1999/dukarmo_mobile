import 'package:dukarmo_app/api/login_api.dart';
import 'package:dukarmo_app/domain/session.dart';
import 'package:dukarmo_app/managers/common/base_manager.dart';

class LoginManager extends BaseManager<LoginApi> {
  LoginManager({mockedApi});

  Future<Session> login(String user, String password) async {
    final response = await api.login(user, password);

    if (response.error == null) {
      return Session.fromJsonModel(response.data);
    } else {
      throw Exception('Login failed');
    }
  }
}
