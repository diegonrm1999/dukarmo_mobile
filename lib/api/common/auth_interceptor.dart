import 'dart:convert';
import 'dart:io';
import 'package:dukarmo_app/enums/user_role.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/services/session_service.dart';

class AuthInterceptor {
  final _sessionService = getSingleton<SessionService>();
  final _navigationService = getSingleton<NavigationService>();
  final String baseUrl;

  AuthInterceptor({required this.baseUrl});

  Future<http.Response> intercept(
    Future<http.Response> Function() request,
    String url,
  ) async {
    try {
      final response = await request();

      if (response.statusCode == 401) {
        final refreshed = await _refreshToken();
        if (refreshed) {
          return await request();
        } else {
          await _handleAuthFailure();
          throw TokenExpiredException('Session expired, please login again');
        }
      }

      return response;
    } catch (e) {
      if (e is! TokenExpiredException) {
        throw Exception('Network error: ${e.toString()}');
      }
      rethrow;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final token = await _sessionService.getRefreshToken();
      if (token == null) return false;

      final response = await http.post(
        Uri.parse('${baseUrl}auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': token}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['token'];

        await _sessionService.updateToken(newAccessToken);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _handleAuthFailure() async {
    final session = _sessionService.currentSession;

    if ((session?.role == UserRole.Cashier ||
            session?.role == UserRole.Manager) &&
        Platform.isAndroid) {
      try {
        await FirebaseMessaging.instance.unsubscribeFromTopic(
          'cashier_${session!.userId}',
        );
      } catch (e) {
        Exception('Error al desuscribirse: ${e.toString()}');
      }
    }

    try {
      await _sessionService.deleteToken();
      _navigationService.offAllNamed(AppRoutes.login);
    } catch (e) {
      Exception('Error al cerrar sesión: ${e.toString()}');
    }
  }
}

class TokenExpiredException implements Exception {
  final String message;
  TokenExpiredException(this.message);

  @override
  String toString() => message;
}
