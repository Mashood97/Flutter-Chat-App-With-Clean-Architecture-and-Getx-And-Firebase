import 'package:flutter_push_notification_proj/features/chat/data/datasources/remote/user_list_firebase_remote_source.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/entities/user.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/repositories/user_list_firebase_repo.dart';

class UserListFireBaseRepoImplementation implements UserListFirebaseRepository {
  UserListFirebaseRemoteSource? firebaseRemote;
  UserListFireBaseRepoImplementation({this.firebaseRemote});

  @override
  Future<List<UserEntity>> getUserListFromFirebase() =>
      firebaseRemote!.getUserListFromFirebase();
}
