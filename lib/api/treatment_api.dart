import 'package:dukarmo_app/api/common/http.dart';
import 'package:dukarmo_app/api/common/http_result.dart';
import 'package:dukarmo_app/api/enum/http_method.dart';
import 'package:dukarmo_app/core/locator.dart';

class TreatmentApi {
  final _http = getSingleton<Http>();

  Future<HttpResult> getTreatments() async {
    return await _http.sendRequest("treatments/all", method: HttpMethod.get);
  }
}
