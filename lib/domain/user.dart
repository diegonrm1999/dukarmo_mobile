import 'package:dukarmo_app/enums/user_role.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final UserRole role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'role': role.name,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      role: UserRole.values.firstWhere(
        (role) => role.name == (json['role'] as String?),
        orElse: () => UserRole.Unknown,
      ),
    );
  }
}
