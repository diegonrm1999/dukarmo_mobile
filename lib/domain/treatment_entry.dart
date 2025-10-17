class TreatmentEntry {
  String? treatmentId;
  double? price;

  TreatmentEntry({this.treatmentId, this.price});
  Map<String, dynamic> toJson() {
    return {'treatmentId': treatmentId, 'price': price};
  }
}
