import 'package:dukarmo_app/api/common/http.dart';
import 'package:dukarmo_app/api/common/http_result.dart';
import 'package:dukarmo_app/api/enum/http_method.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/dto/order_dto.dart';
import 'package:dukarmo_app/enums/payment_method.dart';

class OrderApi {
  final _http = getSingleton<Http>();

  Future<HttpResult> getOrders() async {
    return await _http.sendRequest("orders/active", method: HttpMethod.get);
  }

  Future<HttpResult> restoreOrder(String id) async {
    return await _http.sendRequest(
      "orders/$id/restore",
      method: HttpMethod.patch,
    );
  }

  Future<HttpResult> getCompletedOrders() async {
    return await _http.sendRequest("orders/completed", method: HttpMethod.get);
  }

  Future<HttpResult> getOrderById(String orderId) async {
    return await _http.sendRequest("orders/$orderId", method: HttpMethod.get);
  }

  Future<HttpResult> createOrder(OrderDto order) async {
    return await _http.sendRequest(
      "orders",
      method: HttpMethod.post,
      body: order.toJson(),
    );
  }

  Future<HttpResult> completeOrder(
    String id,
    PaymentMethod method,
    String ticketNumber,
  ) async {
    return await _http.sendRequest(
      "orders/$id/complete",
      method: HttpMethod.patch,
      body: {"paymentMethod": method.value, "ticketNumber": ticketNumber},
    );
  }

  Future<HttpResult> updateOrder(OrderDto order, String id) async {
    return await _http.sendRequest(
      "orders/$id",
      method: HttpMethod.patch,
      body: order.toJson(),
    );
  }

  Future<HttpResult> cancelOrder(String id) async {
    return await _http.sendRequest(
      "orders/$id/cancel",
      method: HttpMethod.post,
    );
  }

  Future<HttpResult> sendReceipt(String id) async {
    return await _http.sendRequest(
      "orders/$id/send-receipt",
      method: HttpMethod.post,
    );
  }
}
