class Client {
  final String id;
  final String name;
  final String dni;
  final String? phone;
  final String? email;

  Client({
    required this.id,
    required this.name,
    required this.dni,
    this.phone,
    this.email,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as String,
      name: json['name'] as String,
      dni: json['dni'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );
  }
  
}