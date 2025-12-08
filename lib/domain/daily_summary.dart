import 'package:dukarmo_app/domain/payment_summary.dart';
import 'package:dukarmo_app/domain/stylist_summary.dart';

class DailySummary {
  final String date;
  final String cashierId;
  final double totalEarnings;
  final int totalOrders;
  final PaymentSummary payments;
  final List<StylistSummary> ordersByStylist;

  DailySummary({
    required this.date,
    required this.cashierId,
    required this.totalEarnings,
    required this.totalOrders,
    required this.payments,
    required this.ordersByStylist,
  });

  factory DailySummary.fromJson(Map<String, dynamic> json) {
    return DailySummary(
      date: json['date'] as String,
      cashierId: json['cashierId'] as String,
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      totalOrders: json['totalOrders'] as int,
      payments: PaymentSummary.fromJson(json['payments']),
      ordersByStylist: (json['ordersByStylist'] as List<dynamic>)
          .map((e) => StylistSummary.fromJson(e))
          .toList(),
    );
  }
}
