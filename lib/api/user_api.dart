import 'package:dukarmo_app/api/common/http.dart';
import 'package:dukarmo_app/api/common/http_result.dart';
import 'package:dukarmo_app/api/enum/http_method.dart';
import 'package:dukarmo_app/core/locator.dart';

class UserApi {
  final _http = getSingleton<Http>();

  Future<HttpResult> getCashiers() async {
    return await _http.sendRequest('users/cashiers', method: HttpMethod.get);
  }

  Future<HttpResult> getStylist() async {
    return await _http.sendRequest('users/stylists', method: HttpMethod.get);
  }
}
