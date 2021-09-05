

import 'package:flutter_push_notification_proj/features/chat/domain/entities/user.dart';

abstract class UserListFirebaseRemoteSource {
  Future<List<UserEntity>> getUserListFromFirebase();
}
