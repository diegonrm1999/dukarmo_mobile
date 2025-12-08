import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/order.dart';
import 'package:dukarmo_app/domain/order_treatment.dart';
import 'package:dukarmo_app/enums/payment_method.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/navigation_service.dart';
import 'package:dukarmo_app/services/order_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';

class CheckoutController extends ChangeNotifier {
  TextEditingController numberTicketController = TextEditingController();
  GoRouterState? state;
  Order? currentOrder;
  bool _isDisposed = false;
  final ValueNotifier<StatusPage> statusPage = ValueNotifier(
    StatusPage.loading,
  );
  final ValueNotifier<bool> isSubmitLoading = ValueNotifier(false);
  final ValueNotifier<PaymentMethod> selectedPaymentMethod = ValueNotifier(
    PaymentMethod.card,
  );

  final _orderService = getSingleton<OrderService>();
  final _snackbar = getSingleton<Snackbar>();
  final _navigationService = getSingleton<NavigationService>();

  CheckoutController({this.state}) {
    _onInit();
  }

  @override
  void dispose() {
    numberTicketController.dispose();
    isSubmitLoading.dispose();
    selectedPaymentMethod.dispose();
    statusPage.dispose();
    _isDisposed = true;
    super.dispose();
  }

  List<OrderTreatment> get treatmentList => currentOrder?.treatments ?? [];

  String get titleMessage {
    return "Completar Orden";
  }

  Future<void> _onInit() async {
    try {
      if (state != null) {
        await _loadSelectedOrder();
      }
      statusPage.value = StatusPage.success;
    } catch (e) {
      statusPage.value = StatusPage.error;
    } finally {
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  Future<void> _loadSelectedOrder() async {
    final orderId = state!.extra as String;
    currentOrder = await _orderService.getSelectedOrder(orderId);
    numberTicketController.text = currentOrder?.ticketNumber ?? '';
  }

  String get selectedServiceAmount {
    if (currentOrder == null) return "0.00";
    return currentOrder!.treatments
        .map((e) => e.price)
        .reduce((a, b) => a + b)
        .toStringAsFixed(2);
  }

  void onPaymentMethodSelected(PaymentMethod method) {
    selectedPaymentMethod.value = method;
  }

  bool validateFields() {
    if (numberTicketController.text.isEmpty) {
      _snackbar.show("Por favor, complete todos los campos");
      return true;
    }
    return false;
  }

  void onBackPressed() {
    _navigationService.offAllNamed(AppRoutes.home);
  }

  Future<void> onSubmitOrder() async {
    if (validateFields()) return;
    try {
      isSubmitLoading.value = true;
      final order = await _orderService.completeOrder(
        currentOrder!.id,
        selectedPaymentMethod.value,
        numberTicketController.text.trim(),
      );
      isSubmitLoading.value = false;
      _navigationService.offAllNamed(AppRoutes.complete, extra: order);
    } catch (e) {
      _snackbar.show("Error al completar la orden");
      isSubmitLoading.value = false;
    }
  }
}
