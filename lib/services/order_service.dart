import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/dto/order_dto.dart';
import 'package:dukarmo_app/domain/list_item/order_list_item.dart';
import 'package:dukarmo_app/domain/order.dart';
import 'package:dukarmo_app/enums/payment_method.dart';
import 'package:dukarmo_app/managers/order_manager.dart';

class OrderService {
  final orderManager = getSingleton<OrderManager>();

  Future<List<OrderListItem>> fetchOrders() async {
    return orderManager.fetchOrders();
  }

  Future<void> restoreOrder(String id) async {
    return orderManager.restoreOrder(id);
  }

  Future<List<OrderListItem>> fetchCompletedOrders() async {
    return orderManager.fetchCompletedOrders();
  }

  Future<Order> getSelectedOrder(String orderId) async {
    return orderManager.getOrderById(orderId);
  }

  Future<List<OrderListItem>> fetchIncomingOrders() async {
    return orderManager.fetchIncomingOrders();
  }

  Future<void> createOrder(OrderDto order) async {
    await orderManager.createOrder(order);
  }

  Future<Order> completeOrder(
    String id,
    PaymentMethod method,
    String ticketNumber,
  ) async {
    return await orderManager.completeOrder(id, method, ticketNumber);
  }

  Future<void> updateOrder(OrderDto order, String id) async {
    await orderManager.updateOrder(order, id);
  }

  Future<void> cancelOrder(String id) async {
    await orderManager.cancelOrder(id);
  }

  Future<void> sendReceipt(String id) async {
    await orderManager.sendReceipt(id);
  }
}
