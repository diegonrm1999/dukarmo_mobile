import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/widgets/loading/order_loading.dart';

class StatusPageContent extends StatelessWidget {
  final StatusPage status;
  final Widget child;
  final void Function()? onRefresh;

  const StatusPageContent({
    super.key,
    required this.status,
    required this.child,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StatusPage.loading:
        return Center(
          child: PulsingIcon(
            isLoading: true,
            icon: Icons.shopping_bag,
            color: Colors.black,
          ),
        );
      case StatusPage.success:
        return child;
      case StatusPage.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: AppColors.primaryButton,
                  size: 64,
                ),
                onPressed: onRefresh,
              ),
              const SizedBox(height: 24),
              Text(
                'Algo salió mal...',
                style: TextStyleWrapper.xlBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'No pudimos cargar los datos.\nPor favor, intenta nuevamente.',
                style: TextStyleWrapper.mdBlackRegular,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
    }
  }
}
