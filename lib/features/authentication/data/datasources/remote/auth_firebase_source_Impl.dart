import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_push_notification_proj/features/authentication/data/datasources/remote/auth_firebase_source.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/entities/auth_entity.dart';

class AuthFirebaseSourceImpl implements AuthFirebaseRemoteSource {
  final FirebaseAuth auth;
  final FirebaseMessaging firebaseMessaging;
  final FirebaseFirestore fireStore;

  AuthFirebaseSourceImpl({
    required this.auth,
    required this.firebaseMessaging,
    required this.fireStore,
  });

  @override
  Future<UserCredential> loginWithUser({AuthEntity? authEntity}) async{
      UserCredential user = await   auth.signInWithEmailAndPassword(
          email: authEntity!.email!, password: authEntity.password!);
      return user;
  }
  @override
  Future<UserCredential> signUpUser({AuthEntity? authEntity}) async{
  UserCredential user = await  auth.createUserWithEmailAndPassword(
        email: authEntity!.email!, password: authEntity.password!);

      return user;
  }

  @override
  Future<String?> getToken() =>
    firebaseMessaging.getToken();

  @override
  Future<void> addUserToFirebaseDB({String? email, String? token,String? uid}) {
    return fireStore.collection("Users").doc(email).set({
      "email": email,
      "token": token,
      "userId":uid,
    });
  }



}
