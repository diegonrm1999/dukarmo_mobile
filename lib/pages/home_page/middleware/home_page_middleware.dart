import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/pages/common/middleware/middleware.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/session_service.dart';

class HomePageMiddleware extends Middleware {
  final _sessionService = getSingleton<SessionService>();

  @override
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    final isLoggedIn = _sessionService.isLoggedIn();
    if (!isLoggedIn) {
      return AppRoutes.login;
    }
    return null;
  }
}
