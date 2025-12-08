class StylistSummary {
  final String stylistId;
  final String stylistName;
  final int count;

  StylistSummary({
    required this.stylistId,
    required this.stylistName,
    required this.count,
  });

  factory StylistSummary.fromJson(Map<String, dynamic> json) {
    return StylistSummary(
      stylistId: json['stylistId'] as String,
      stylistName: json['stylistName'] as String,
      count: json['count'] as int,
    );
  }
}