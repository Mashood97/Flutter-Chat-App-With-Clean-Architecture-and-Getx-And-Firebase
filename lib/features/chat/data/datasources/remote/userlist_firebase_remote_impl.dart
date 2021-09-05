import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_push_notification_proj/features/chat/data/datasources/remote/user_list_firebase_remote_source.dart';
import 'package:flutter_push_notification_proj/features/chat/data/models/user_model.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/entities/user.dart';

class UserListFirebaseRemoteImplementation
    implements UserListFirebaseRemoteSource {
  final FirebaseFirestore fireStore;
  UserListFirebaseRemoteImplementation({required this.fireStore});
  @override
  Future<List<UserEntity>> getUserListFromFirebase() async {
    QuerySnapshot querySnapshot = await fireStore.collection("Users").get();
    print(querySnapshot.docs);
    List<UserEntity> userList = [];
    for (QueryDocumentSnapshot item in querySnapshot.docs) {
      userList.add(UserModel(
        email: item.get("email"),
        token: item.get("token"),
        uid: item.get("userId"),

      ));
    }
    return userList;
  }
}
