import 'package:dukarmo_app/enums/status_page.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/order.dart';
import 'package:dukarmo_app/enums/event_type.dart';
import 'package:dukarmo_app/event_bus.dart';
import 'package:dukarmo_app/services/order_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';

class TransactionModalController extends ChangeNotifier {
  final _orderService = getSingleton<OrderService>();
  final _snackbar = getSingleton<Snackbar>();
  final String orderId;
  Order? order;
  StatusPage statusPage = StatusPage.loading;
  String serviceNames = '';

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  TransactionModalController({required this.orderId}) {
    _init();
  }

  Future<void> _init() async {
    try {
      await fetchOrder();
      statusPage = StatusPage.success;
    } catch (e) {
      statusPage = StatusPage.error;
      _snackbar.show("Error al cargar la orden");
    }
    notifyListeners();
  }

  Future<void> fetchOrder() async {
    order = await _orderService.getSelectedOrder(orderId);
    serviceNames = (order?.treatments ?? [])
        .map((t) => t.treatment.name)
        .join(', ');
  }

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }

  Future<void> restoreOrder(BuildContext context) async {
    try {
      isLoading.value = true;
      await _orderService.restoreOrder(orderId);
      OrderEventBus.notifyNewOrderCreated(EventType.transaction);
      isLoading.value = false;
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      isLoading.value = false;
      _snackbar.show('Error al restaurar la orden');
    }
  }
}
