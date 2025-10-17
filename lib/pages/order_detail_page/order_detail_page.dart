import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/domain/order.dart';
import 'package:dukarmo_app/pages/order_detail_page/complete_order_controller.dart';
import 'package:dukarmo_app/services/order_service.dart';
import 'package:dukarmo_app/widgets/background_scaffold.dart';
import 'package:dukarmo_app/widgets/order_detail/order_client_info.dart';
import 'package:dukarmo_app/widgets/order_detail/order_summary.dart';
import 'package:dukarmo_app/widgets/order_detail/order_treatment_list.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CompleteOrderController(),
      child: Builder(
        builder: (context) {
          final controller = context.read<CompleteOrderController>();
          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Orden #${order.orderNumber}",
                style: TextStyleWrapper.lgBold,
              ),
              leading: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: controller.onBackPressed,
              ),
            ),
            body: BackgroundScaffold(
              backgroundPath: "assets/images/home_wallpaper.webp",
              transparency: 0.1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OrderClientInfo(
                      client: order.client,
                      stylist: order.stylist,
                      cashier: order.cashier,
                    ),
                    const SizedBox(height: 20),
                    OrderTreatmentList(treatments: order.treatments),
                    const SizedBox(height: 20),
                    OrderSummary(
                      total: order.totalPrice,
                      paid: order.paidAmount,
                      onSendReceipt: () => _sendReceipt(order),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _sendReceipt(Order order) async {
    final snackBar = getSingleton<Snackbar>();
    try {
      final orderService = getSingleton<OrderService>();
      if (order.client.email == null || order.client.email!.isEmpty) {
        snackBar.show("El cliente no tiene un correo electrónico válido");
        return;
      }
      orderService.sendReceipt(order.id);
      snackBar.show("Recibo enviado correctamente");
    } catch (e) {
      snackBar.show("Error al enviar el recibo");
    }
  }
}
