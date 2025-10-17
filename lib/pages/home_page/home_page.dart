import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/pages/home_page/home_controller.dart';
import 'package:dukarmo_app/widgets/order_list/order_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Consumer<HomeController>(
        builder: (context, controller, _) => controller.createOrderEnabled
            ? TextButton.icon(
                onPressed: controller.onNewOrderTap,
                icon: Icon(Icons.add, color: Colors.black),
                label: Text('Nueva Orden', style: TextStyleWrapper.lgBold),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.homeBackground,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            : const SizedBox(),
      ),
      body: Consumer<HomeController>(
        builder: (_, controller, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hola, ${controller.sessionName}', style: TextStyleWrapper.lgBold),
                  const SizedBox(height: 8),
                  Image.asset(
                    'assets/images/logo_wallpaper.png',
                    height: 30,
                    cacheWidth: 200,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: OrderList(
                onRefresh: controller.onRefresh,
                orders: controller.orders,
                status: controller.statusPage,
                onItemTap: (index) => controller.onOrderTap(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
