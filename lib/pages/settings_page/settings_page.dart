import 'package:dukarmo_app/pages/settings_page/settings_controller.dart';
import 'package:dukarmo_app/widgets/buttons/loading_context_button.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SettingsController(),
      dispose: (_, controller) => controller.dispose(),
      child: Builder(
        builder: (context) {
          final controller = context.read<SettingsController>();
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: double.infinity,
              child: Column(
                children: [
                  if (controller.isDailySummaryEnabled) ...[
                    const SummaryButton(),
                    const SizedBox(height: 25),
                  ],
                  const SettingsPageButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SummaryButton extends StatelessWidget {
  const SummaryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SettingsController>();
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: LoadingContextButton(
        text: 'Resumen Diario',
        onPressed: () => controller.onSummaryPressed(),
        backgroundColor: AppColors.primaryButton,
      ),
    );
  }
}

class SettingsPageButton extends StatelessWidget {
  const SettingsPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SettingsController>();
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isLoading,
      builder: (_, isLoading, __) => SizedBox(
        width: double.infinity,
        height: 55,
        child: LoadingContextButton(
          text: 'Cerrar Sesión',
          isLoading: isLoading,
          onPressed: () => controller.onLogoutPressed(context),
          backgroundColor: AppColors.primaryButton,
        ),
      ),
    );
  }
}
