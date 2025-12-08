// ignore_for_file: empty_catches

import 'dart:io';

import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/enums/user_role.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/session_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnknownRolePage extends StatelessWidget {
  const UnknownRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.block, color: AppColors.primaryButton, size: 72),
                SizedBox(height: 24),
                Text(
                  'Rol no soportado',
                  style: TextStyleWrapper.xlBold.copyWith(
                    color: AppColors.primaryButton,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Tu cuenta tiene un rol que no es compatible con esta aplicación.',
                  style: TextStyleWrapper.lgBold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () async {
                    final sessionService = getSingleton<SessionService>();
                    final snackBar = getSingleton<Snackbar>();
                    final session = sessionService.currentSession;

                    if ((session?.role == UserRole.Cashier ||
                            session?.role == UserRole.Manager) &&
                        Platform.isAndroid) {
                      try {
                        await FirebaseMessaging.instance.unsubscribeFromTopic(
                          'cashier_${session!.userId}',
                        );
                      } catch (e) {
                        snackBar.show(
                          'Error al desuscribirse: ${e.toString()}',
                        );
                      }
                    }

                    try {
                      await sessionService.deleteToken();
                      if (context.mounted) {
                        context.go(AppRoutes.login);
                        return;
                      }
                    } catch (e) {
                      snackBar.show('Error al cerrar sesión: ${e.toString()}');
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Cerrar sesión'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryButton,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
