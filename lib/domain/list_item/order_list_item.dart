import 'package:dukarmo_app/core/utils/date_formatter.dart';

class OrderListItem {
  final String id;
  final int orderNumber;
  final ClientListItem client;
  final StylistListItem stylist;
  final double totalPrice;
  final String createdAt;

  OrderListItem({
    required this.id,
    required this.orderNumber,
    required this.client,
    required this.stylist,
    required this.totalPrice,
    required this.createdAt,
  });

  factory OrderListItem.fromJson(Map<String, dynamic> json) {
    return OrderListItem(
      id: json['id'] as String,
      orderNumber: (json['orderNumber'] as num).toInt(),
      client: ClientListItem.fromJson(json['client'] as Map<String, dynamic>),
      stylist: StylistListItem.fromJson(
        json['stylist'] as Map<String, dynamic>,
      ),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: DateFormatter.formatWithTime(json['createdAt'] as String),
    );
  }
}

class ClientListItem {
  final String name;

  ClientListItem({required this.name});

  factory ClientListItem.fromJson(Map<String, dynamic> json) {
    return ClientListItem(name: json['name'] as String);
  }
}

class StylistListItem {
  final String name;

  StylistListItem({required this.name});

  factory StylistListItem.fromJson(Map<String, dynamic> json) {
    return StylistListItem(name: json['firstName'] as String);
  }
}
