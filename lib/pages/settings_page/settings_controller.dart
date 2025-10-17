import 'dart:io';

import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/enums/user_role.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/navigation_service.dart';
import 'package:dukarmo_app/services/session_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsController {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final sessionService = getSingleton<SessionService>();
  final navigationService = getSingleton<NavigationService>();
  final _snackBar = getSingleton<Snackbar>();

  void dispose() {
    isLoading.dispose();
  }

  Future<void> onLogoutPressed(BuildContext context) async {
    isLoading.value = true;
    final session = sessionService.currentSession;

    if ((session?.role == UserRole.Cashier ||
            session?.role == UserRole.Manager) &&
        Platform.isAndroid) {
      try {
        await FirebaseMessaging.instance.unsubscribeFromTopic(
          'cashier_${session!.userId}',
        );
      } catch (e) {
        _snackBar.show('Error al desuscribirse: ${e.toString()}');
      }
    }

    try {
      await sessionService.deleteToken();
      isLoading.value = false;
      if (context.mounted) {
        context.go(AppRoutes.login);
        return;
      }
    } catch (e) {
      isLoading.value = false;
      _snackBar.show('Error al cerrar sesión: ${e.toString()}');
    }
  }
}
