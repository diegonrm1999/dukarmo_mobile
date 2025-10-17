import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/pages/main_page.dart/unknown_role_page.dart';
import 'package:dukarmo_app/pages/main_page.dart/wrappers/manager_main_wrapper.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/enums/user_role.dart';
import 'package:dukarmo_app/pages/main_page.dart/wrappers/cashier_main_wrapper.dart';
import 'package:dukarmo_app/pages/main_page.dart/wrappers/specialist_main_wrapper.dart';
import 'package:dukarmo_app/services/session_service.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getSingleton<SessionService>();
    final role = authService.getRole();

    return switch (role) {
      UserRole.Cashier => const CashierMainWrapper(),
      UserRole.Manager => const ManagerMainWrapper(),
      UserRole.Operator => const SpecialistMainWrapper(),
      _ => UnknownRolePage(),
    };
  }
}
