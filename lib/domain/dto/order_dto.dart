import 'package:dukarmo_app/domain/treatment_entry.dart';

class OrderDto {
  final String clientDni;
  final String clientName;
  final String? clientPhone;
  final String? clientEmail;
  final String stylistId;
  final String cashierId;
  final List<TreatmentEntry> treatments;

  OrderDto({
    required this.clientDni,
    required this.clientName,
    this.clientPhone,
    this.clientEmail,
    required this.stylistId,
    required this.cashierId,
    required this.treatments,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientDni': clientDni,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'stylistId': stylistId,
      'cashierId': cashierId,
      'clientEmail': clientEmail,
      'treatments': treatments.map((e) => e.toJson()).toList(),
    };
  }
}
