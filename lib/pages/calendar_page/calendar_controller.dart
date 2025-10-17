import 'package:dukarmo_app/domain/list_item/order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/services/order_service.dart';

class CalendarController extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  List<OrderListItem> orders = [];
  StatusPage statusPage = StatusPage.loading;
  bool _isDisposed = false;

  final _orderService = getSingleton<OrderService>();

  CalendarController() {
    _init();
  }

  Future<void> _init() async {
    try {
      await _fetchOrders();
      statusPage = StatusPage.success;
    } catch (e) {
      statusPage = StatusPage.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> _fetchOrders() async {
    await Future.delayed(Duration(seconds: 2));
    orders = await _orderService.fetchIncomingOrders();
  }

  Future<void> onRefresh() async {
    try {
      statusPage = StatusPage.loading;
      notifyListeners();
      await _fetchOrders();
      statusPage = StatusPage.success;
    } catch (e) {
      statusPage = StatusPage.error;
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    selectedDate = focusedDay;
    statusPage = StatusPage.loading;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    statusPage = StatusPage.success;
    if (_isDisposed) return;
    notifyListeners();
  }
}
