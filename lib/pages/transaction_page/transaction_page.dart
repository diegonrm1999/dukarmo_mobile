import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/pages/transaction_page/transaction_controller.dart';
import 'package:dukarmo_app/widgets/order_list/order_list.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<TransactionController>(
        builder: (_, controller, builder) => OrderList(
          backgroundColor: AppColors.secondaryButton,
          onItemTap: controller.onItemTap,
          onRefresh: controller.onRefresh,
          orders: controller.orders,
          status: controller.statusPage,
          showTransactionModal: true,
        ),
      ),
    );
  }
}
