import 'package:dukarmo_app/domain/treatment.dart';

class OrderTreatment {
  final Treatment treatment;
  final double price;

  OrderTreatment({required this.treatment, required this.price});

  factory OrderTreatment.fromMap(Map<String, dynamic> json) {
    return OrderTreatment(
      treatment: Treatment.fromJsonModel(
        json['treatment'] as Map<String, dynamic>,
      ),
      price: (json['price'] as num).toDouble(),
    );
  }
}
