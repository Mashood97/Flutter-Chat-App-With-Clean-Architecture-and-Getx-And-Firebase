import 'package:flutter_push_notification_proj/features/chat/domain/entities/user.dart';

abstract class UserListFirebaseRepository {
  Future<List<UserEntity>> getUserListFromFirebase();
}
