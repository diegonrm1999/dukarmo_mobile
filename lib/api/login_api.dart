import 'package:dukarmo_app/api/common/http.dart';

import 'package:dukarmo_app/api/common/http_result.dart';
import 'package:dukarmo_app/api/enum/http_method.dart';
import 'package:dukarmo_app/core/locator.dart';

class LoginApi {
  final Http _http = getSingleton<Http>();

  Future<HttpResult> login(String email, String password) async {
    final response = _http.sendRequest(
      'auth/login',
      body: {'email': email, 'password': password},
      method: HttpMethod.post,
      requiresAuth: false,
    );
    return response;
  }
}
