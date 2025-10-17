import 'package:dukarmo_app/api/order_api.dart';
import 'package:dukarmo_app/domain/dto/order_dto.dart';
import 'package:dukarmo_app/domain/list_item/order_list_item.dart';
import 'package:dukarmo_app/domain/order.dart';
import 'package:dukarmo_app/enums/payment_method.dart';
import 'package:dukarmo_app/managers/common/base_manager.dart';

class OrderManager extends BaseManager<OrderApi> {
  Future<List<OrderListItem>> fetchOrders() async {
    final result = await api.getOrders();
    if (result.error == null) {
      final orders = result.data as List<dynamic>;
      return orders.map((e) => OrderListItem.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar las ordenes");
    }
  }

  Future<void> restoreOrder(String id) async {
    final result = await api.restoreOrder(id);
    if (result.error == null) {
      return;
    } else {
      throw Exception("Error al cargar las ordenes");
    }
  }

  Future<List<OrderListItem>> fetchCompletedOrders() async {
    final result = await api.getCompletedOrders();
    if (result.error == null) {
      final orders = result.data as List<dynamic>;
      return orders.map((e) => OrderListItem.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar las ordenes");
    }
  }

  Future<List<OrderListItem>> fetchIncomingOrders() async {
    return [];
  }

  Future<Order> getOrderById(String orderId) async {
    final result = await api.getOrderById(orderId);
    if (result.error == null) {
      return Order.fromJson(result.data);
    } else {
      throw Exception("Error al obtener la orden");
    }
  }

  Future<void> createOrder(OrderDto orderDto) async {
    final result = await api.createOrder(orderDto);
    if (result.error == null) {
      return;
    } else {
      throw Exception("Error al crear la orden");
    }
  }

  Future<Order> completeOrder(
    String id,
    PaymentMethod method,
    String ticketNumber,
  ) async {
    final result = await api.completeOrder(id, method, ticketNumber);
    if (result.error == null) {
      return Order.fromJson(result.data);
    } else {
      throw Exception("Error al completar la orden");
    }
  }

  Future<void> updateOrder(OrderDto orderDto, String id) async {
    final result = await api.updateOrder(orderDto, id);
    if (result.error == null) {
      return;
    } else {
      throw Exception("Error al actualizar la orden");
    }
  }

  Future<void> cancelOrder(String id) async {
    final result = await api.cancelOrder(id);
    if (result.error == null) {
      return;
    } else {
      throw Exception("Error al cancelar la orden");
    }
  }

  Future<void> sendReceipt(String id) async {
    final result = await api.sendReceipt(id);
    if (result.error == null) {
      return;
    } else {
      throw Exception("Error al enviar el recibo");
    }
  }
}
