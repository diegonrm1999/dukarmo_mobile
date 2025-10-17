import 'dart:async';

import 'package:dukarmo_app/domain/list_item/order_list_item.dart';
import 'package:dukarmo_app/pages/transaction_page/transaction_modal.dart';
import 'package:dukarmo_app/pages/transaction_page/transaction_modal_controller.dart';
import 'package:dukarmo_app/services/navigation_service.dart';
import 'package:dukarmo_app/services/session_service.dart';
import 'package:dukarmo_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/enums/event_type.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/event_bus.dart';
import 'package:dukarmo_app/services/order_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class TransactionController extends ChangeNotifier {
  List<OrderListItem> orders = [];
  bool _isDisposed = false;
  StatusPage statusPage = StatusPage.loading;

  final _orderService = getSingleton<OrderService>();
  final _snackBar = getSingleton<Snackbar>();
  final _navigationService = getSingleton<NavigationService>();
  final _socketService = getSingleton<SocketService>();
  final _sessionService = getSingleton<SessionService>();
  StreamSubscription? _orderSubscription;

  TransactionController() {
    _init();
    _listenEventStream();
    _initOrderListeners();
  }

  void _initOrderListeners() {
    _socketService.connect();
    final currentUserId = _sessionService.userId;
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
      statusPage = StatusPage.success;
    } catch (e) {
      statusPage = StatusPage.error;
      _snackBar.show("Error al cargar las ordenes");
    }
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Future<void> fetchOrders() async {
    orders = await _orderService.fetchCompletedOrders();
  }

  void onItemTap(int index) {
    final id = orders[index].id;
    showModalBottomSheet(
      context: _navigationService.context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ChangeNotifierProvider(
        create: (_) => TransactionModalController(orderId: id),
        child: TransactionDetailModal(),
      ),
    );
  }

  void _listenEventStream() {
    _orderSubscription = OrderEventBus.stream.listen((event) {
      if (event == EventType.transaction) {
        onRefresh();
      }
    });
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
}
