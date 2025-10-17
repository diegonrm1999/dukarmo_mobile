import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/session.dart';
import 'package:dukarmo_app/enums/user_role.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/auth_service.dart';
import 'package:dukarmo_app/services/navigation_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';

class LoginController extends ChangeNotifier {
  final userTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final _authService = getSingleton<AuthService>();
  final _navigationService = getSingleton<NavigationService>();
  final _snackbar = getSingleton<Snackbar>();

  @override
  void dispose() {
    userTextController.dispose();
    passwordTextController.dispose();
    isLoading.dispose();
    super.dispose();
  }

  Future<void> login() async {
    isLoading.value = true;
    final email = userTextController.text.trim();
    final password = passwordTextController.text.trim();
    try {
      validateForm();
      final session = await _authService.login(email, password);
      await setupNotifications(session);
      _navigationService.offAllNamed(AppRoutes.home);
      isLoading.value = false;
    } on Exception {
      _snackbar.show('Error al iniciar sesión');
      isLoading.value = false;
    }
  }

  void validateForm() {
    if (userTextController.text.isEmpty ||
        passwordTextController.text.isEmpty) {
      throw Exception('Por favor, complete todos los campos');
    }
  }

  Future<void> setupNotifications(Session session) async {
    if (!(session.role == UserRole.Cashier ||
            session.role == UserRole.Manager) ||
        !Platform.isAndroid) {
      return;
    }
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    await messaging.subscribeToTopic('cashier_${session.userId}');
  }
}
