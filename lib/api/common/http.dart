import 'dart:convert';

import 'package:dukarmo_app/api/common/auth_interceptor.dart';
import 'package:dukarmo_app/api/common/http_exception.dart';
import 'package:dukarmo_app/api/enum/http_method.dart';
import 'package:http/http.dart';
import 'package:dukarmo_app/api/common/http_result.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/services/session_service.dart';

class Http {
  static const String _baseUrl = 'https://api.dukarmo.com/';

  final _sessionService = getSingleton<SessionService>();
  late final AuthInterceptor _authInterceptor;

  Http() {
    _authInterceptor = AuthInterceptor(baseUrl: _baseUrl);
  }

  Future<HttpResult<T>> sendRequest<T>(
    String endpoint, {
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    try {
      final url = _baseUrl + endpoint;
      Response response;
      if (requiresAuth) {
        response = await _authInterceptor.intercept(
          () => _executeRequest(url, method, body, headers),
          url,
        );
      } else {
        response = await _executeRequest(url, method, body, headers);
      }
      return _handleResponse<T>(response);
    } catch (e) {
      return HttpResult<T>(
        data: null,
        statusCode: 0,
        error: HttpError(
          exception: e is Exception ? e : Exception(e.toString()),
          stackTrace: StackTrace.current,
          data: null,
        ),
      );
    }
  }

  Future<Response> _executeRequest(
    String url,
    HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? customHeaders,
  ) async {
    final headers = await _buildHeaders(customHeaders);
    final uri = Uri.parse(url);
    switch (method) {
      case HttpMethod.get:
        return await get(uri, headers: headers);
      case HttpMethod.post:
        return await post(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case HttpMethod.patch:
        return await patch(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case HttpMethod.put:
        return await put(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case HttpMethod.delete:
        return await delete(uri, headers: headers);
    }
  }

  Future<Map<String, String>> _buildHeaders([
    Map<String, String>? customHeaders,
  ]) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final token = await _getCurrentToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    return headers;
  }

  Future<String?> _getCurrentToken() async {
    return _sessionService.currentSession?.token;
  }

  HttpResult<T> _handleResponse<T>(Response response) {
    if (_isSuccessStatusCode(response.statusCode)) {
      final data = response.body.isNotEmpty ? jsonDecode(response.body) : null;
      return HttpResult<T>(
        data: data,
        statusCode: response.statusCode,
        error: null,
      );
    } else {
      final errorMessage = _extractErrorMessage(response);
      return HttpResult<T>(
        data: null,
        statusCode: response.statusCode,
        error: HttpError(
          exception: HttpException(errorMessage, response.statusCode),
          stackTrace: StackTrace.current,
          data: response.body,
        ),
      );
    }
  }

  bool _isSuccessStatusCode(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  String _extractErrorMessage(Response response) {
    try {
      final errorBody = jsonDecode(response.body);
      return errorBody['message'] ??
          errorBody['error'] ??
          'HTTP ${response.statusCode}: ${response.reasonPhrase}';
    } catch (e) {
      return 'HTTP ${response.statusCode}: ${response.reasonPhrase}';
    }
  }
}
