import 'package:flutter/material.dart';
import 'package:dukarmo_app/pages/home_page/home_controller.dart';
import 'package:dukarmo_app/pages/main_tab_page/configurations/tab_role_configuration.dart';
import 'package:dukarmo_app/pages/main_tab_page/main_tab_controller.dart';
import 'package:dukarmo_app/pages/main_tab_page/main_tab_page.dart';
import 'package:provider/provider.dart';

class SpecialistMainWrapper extends StatelessWidget {
  const SpecialistMainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              MainTabController(config: SpecialistTabConfiguration()),
        ),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: const MainTabPage(),
    );
  }
}
