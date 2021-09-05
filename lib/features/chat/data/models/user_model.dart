import 'package:flutter_push_notification_proj/features/authentication/domain/entities/auth_entity.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    final String? email,
    final String? token,
    final String? uid,
  }) : super(
          email: email!,
          token: token!,
          uid: uid,
        );

//This is where we define from json and to json methods.

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      token: json['token'],
      uid: json['userId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "token": token,
      "userId": uid,
    };
  }
}
