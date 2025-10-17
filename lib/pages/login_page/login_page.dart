import 'package:flutter/material.dart';
import 'package:dukarmo_app/pages/login_page/login_content_body.dart';
import 'package:dukarmo_app/pages/login_page/login_controller.dart';
import 'package:dukarmo_app/widgets/background_scaffold.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: const Scaffold(
        body: BackgroundScaffold(
          backgroundPath: 'assets/images/login_wallpaper.webp',
          child: LoginContentBody(),
        ),
      ),
    );
  }
}
