import 'package:dukarmo_app/enums/user_role.dart';

class Session {
  final String userId;
  final UserRole role;
  final String token;
  final String name;
  final String refreshToken;

  Session({
    required this.userId,
    required this.role,
    required this.token,
    required this.name,
    required this.refreshToken,
  });

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      userId: map['id'] as String,
      role: UserRole.values.firstWhere(
        (role) => role.name == (map['role'] as String),
        orElse: () => UserRole.Unknown,
      ),
      token: map['token'] as String,
      name: map['name'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  static Session fromJsonModel(Map<String, dynamic> json) =>
      Session.fromMap(json);

  Session copyWith({
    String? userId,
    UserRole? role,
    String? token,
    String? name,
    String? refreshToken,
  }) {
    return Session(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      token: token ?? this.token,
      name: name ?? this.name,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
