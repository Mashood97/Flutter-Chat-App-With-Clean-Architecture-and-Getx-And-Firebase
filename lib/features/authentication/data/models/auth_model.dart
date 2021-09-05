import 'package:flutter_push_notification_proj/features/authentication/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    final String? email,
    final String? password,
  }) : super(
          email: email!,
          password: password!,
        );

//This is where we define from json and to json methods.

  static AuthModel fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
