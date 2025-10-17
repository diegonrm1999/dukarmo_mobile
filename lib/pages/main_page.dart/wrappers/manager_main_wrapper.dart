import 'package:flutter/material.dart';
import 'package:dukarmo_app/pages/home_page/home_controller.dart';
import 'package:dukarmo_app/pages/main_tab_page/configurations/tab_role_configuration.dart';
import 'package:dukarmo_app/pages/main_tab_page/main_tab_controller.dart';
import 'package:dukarmo_app/pages/main_tab_page/main_tab_page.dart';
import 'package:dukarmo_app/pages/transaction_page/transaction_controller.dart';
import 'package:provider/provider.dart';

class ManagerMainWrapper extends StatelessWidget {
  const ManagerMainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainTabController(config: ManagerTabConfiguration()),
        ),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => TransactionController()),
      ],
      child: const MainTabPage(),
    );
  }
}
