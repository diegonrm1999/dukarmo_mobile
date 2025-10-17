import 'dart:async';

import 'package:dukarmo_app/domain/list_item/order_list_item.dart';
import 'package:dukarmo_app/enums/event_type.dart';
import 'package:dukarmo_app/event_bus.dart';
import 'package:dukarmo_app/pages/home_page/order_action_modal.dart';
import 'package:dukarmo_app/services/navigation_service.dart';
import 'package:dukarmo_app/services/socket_service.dart';
import 'package:dukarmo_app/widgets/modal/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/enums/user_role.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/session_service.dart';
import 'package:dukarmo_app/services/order_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';

class HomeController extends ChangeNotifier {
  List<OrderListItem> orders = [];
  bool _isDisposed = false;
  UserRole? currentRole;
  StatusPage statusPage = StatusPage.loading;
  StreamSubscription? _orderSubscription;

  final _sessionService = getSingleton<SessionService>();
  final _orderService = getSingleton<OrderService>();
  final _navigationService = getSingleton<NavigationService>();
  final _snackBar = getSingleton<Snackbar>();
  final _socketService = getSingleton<SocketService>();

  bool get createOrderEnabled =>
      currentRole == UserRole.Operator || currentRole == UserRole.Manager;

  HomeController() {
    _init();
    _listenEventStream();
    _initOrderListeners();
  }

  String get sessionName => _sessionService.currentSession?.name ?? 'Usuario';

  void _listenEventStream() {
    _orderSubscription = OrderEventBus.stream.listen((event) {
      if (event == EventType.transaction) {
        onRefresh();
      }
    });
  }

  void _initOrderListeners() {
    _socketService.connect();
    final currentUserId = _sessionService.userId;
    _socketService.on('order-refresh-$currentUserId', (dynamic data) {
      final userId = data?.toString();
      if (currentUserId != null && userId != currentUserId) {
        onRefresh();
      }
    });
    _socketService.on('complete-refresh-$currentUserId', (dynamic data) {
      final userId = data?.toString();
      if (currentUserId != null && userId != currentUserId) {
        onRefresh();
      }
    });
  }

  @override
  void dispose() {
    _socketService.disconnect();
    _orderSubscription?.cancel();
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _init() async {
    try {
      await fetchOrders();
      currentRole = _sessionService.getRole();
      statusPage = StatusPage.success;
    } catch (e) {
      statusPage = StatusPage.error;
      _snackBar.show("Error al cargar las ordenes");
    }
    if (_isDisposed) return;
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    orders = await _orderService.fetchOrders();
  }

  Future<void> onRefresh() async {
    try {
      await fetchOrders();
      statusPage = StatusPage.success;
    } catch (e) {
      statusPage = StatusPage.error;
      _snackBar.show("Error al actualizar las ordenes");
    } finally {
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  Future<void> onNewOrderTap() async {
    if (currentRole == UserRole.Operator || currentRole == UserRole.Manager) {
      _navigationService.offAllNamed(AppRoutes.newOrder);
    } else {
      _snackBar.show("No tienes permiso para crear una orden");
    }
  }

  void _onEditOrderTap(String orderId) {
    _navigationService.offAllNamed(AppRoutes.orderDetail, extra: orderId);
  }

  void _onCancelOrderTap(String orderId) {
    showDialog(
      context: _navigationService.context,
      builder: (_) => ConfirmDialog(
        title: "Cancelar orden",
        message: "¿Estás seguro que deseas cancelar esta orden?",
        onConfirm: () => _onConfirmCancel(orderId),
      ),
    );
  }

  Future<void> _onConfirmCancel(String orderId) async {
    try {
      await _orderService.cancelOrder(orderId);
      onRefresh();
    } catch (e) {
      _snackBar.show("Error al cancelar la orden");
    }
  }

  void _onCompleteOrderTap(String orderId) {
    _navigationService.offAllNamed(AppRoutes.orderCheckout, extra: orderId);
  }

  void _openModalOrderTap(String id, UserRole currentRole) {
    showModalBottomSheet(
      context: _navigationService.context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => OrderActionModal(
        orderId: id,
        onEdit: _onEditOrderTap,
        onComplete: _onCompleteOrderTap,
        onCancel: _onCancelOrderTap,
        currentRole: currentRole,
      ),
    );
  }

  Future<void> onOrderTap(int index) async {
    final currentRole = _sessionService.getRole();
    switch (currentRole) {
      case UserRole.Cashier:
        _onCompleteOrderTap(orders[index].id);
        break;
      case UserRole.Operator:
        _openModalOrderTap(orders[index].id, UserRole.Operator);
        break;
      case UserRole.Manager:
        _openModalOrderTap(orders[index].id, UserRole.Manager);
        break;
      default:
        break;
    }
  }
}
