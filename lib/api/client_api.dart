import 'package:dukarmo_app/api/common/http.dart';
import 'package:dukarmo_app/api/common/http_result.dart';
import 'package:dukarmo_app/api/enum/http_method.dart';
import 'package:dukarmo_app/core/locator.dart';

class ClientApi {
  final _http = getSingleton<Http>();

  Future<HttpResult> getClientByDni(String dni) async {
    return await _http.sendRequest("clients/dni/$dni", method: HttpMethod.get);
  }
}
