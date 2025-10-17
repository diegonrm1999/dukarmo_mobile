import 'package:dukarmo_app/core/utils/date_formatter.dart';
import 'package:dukarmo_app/core/utils/map_extension.dart';
import 'package:dukarmo_app/domain/client.dart';
import 'package:dukarmo_app/domain/order_treatment.dart';
import 'package:dukarmo_app/domain/user.dart';

class Order {
  final String id;
  final Client client;
  final User stylist;
  final User cashier;
  final String createdAt;
  final List<OrderTreatment> treatments;
  final int orderNumber;
  final double totalPrice;
  final double? paidAmount;
  final String? ticketNumber;

  Order({
    required this.id,
    required this.client,
    required this.stylist,
    required this.createdAt,
    required this.treatments,
    required this.cashier,
    required this.orderNumber,
    required this.totalPrice,
    this.paidAmount,
    this.ticketNumber,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      client: Client.fromJson(json['client'] as Map<String, dynamic>),
      stylist: User.fromJson(json['stylist'] as Map<String, dynamic>),
      cashier: User.fromJson(json['cashier'] as Map<String, dynamic>),
      createdAt: DateFormatter.formatWithTime(json['createdAt'] as String),
      treatments:
          json.toListFromMap('treatments', OrderTreatment.fromMap) ?? [],
      orderNumber: (json['orderNumber'] as num).toInt(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num?)?.toDouble(),
      ticketNumber: json['ticketNumber'] as String?,
    );
  }
}
