class ClientDto {
  final String name;
  final String dni;
  final String? email;
  final String? phone;

  ClientDto({required this.name, required this.dni, this.email, this.phone});

  factory ClientDto.fromJson(Map<String, dynamic> json) {
    return ClientDto(
      name: json['name'] as String,
      dni: json['dni'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }
}
