class Treatment {
  final String id;
  final String name;

  Treatment({
    required this.id,
    required this.name,
  });

  factory Treatment.fromJsonModel(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
