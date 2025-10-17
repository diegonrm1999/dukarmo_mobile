import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/pages/login_page/login_controller.dart';
import 'package:dukarmo_app/widgets/buttons/loading_context_button.dart';
import 'package:dukarmo_app/widgets/textfields/primary_text_field.dart';
import 'package:provider/provider.dart';

class LoginContentBody extends StatelessWidget {
  const LoginContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginController>();

    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.softPink,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                PrimaryTextField(
                  controller: controller.userTextController,
                  hintText: 'Usuario',
                  keyboardType: TextInputType.emailAddress,
                  centerHintText: true,
                ),
                SizedBox(height: 10),
                PrimaryTextField(
                  controller: controller.passwordTextController,
                  hintText: 'Contraseña',
                  obscureText: true,
                  centerHintText: true,
                ),
                SizedBox(height: 10),
                ValueListenableBuilder<bool>(
                  valueListenable: controller.isLoading,
                  builder: (_, isLoading, __) => SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: LoadingContextButton(
                      text: 'INGRESAR',
                      isLoading: isLoading,
                      onPressed: controller.login,
                      backgroundColor: AppColors.loginButtonGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Image.asset(
            'assets/images/logo_wallpaper.png',
            height: 30,
            cacheWidth: 200,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
