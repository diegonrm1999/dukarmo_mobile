class PaymentSummary {
  final double cash;
  final double yape;
  final double card;

  PaymentSummary({required this.cash, required this.yape, required this.card});

  factory PaymentSummary.fromJson(Map<String, dynamic> json) {
    return PaymentSummary(
      cash: (json['cash'] as num).toDouble(),
      yape: (json['yape'] as num).toDouble(),
      card: (json['card'] as num).toDouble(),
    );
  }
}
