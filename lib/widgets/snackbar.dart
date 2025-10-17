import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/services/navigation_service.dart';

class Snackbar {
  final _navigationService = getSingleton<NavigationService>();

   void show(String message) {
    final context = _navigationService.context;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }
}
