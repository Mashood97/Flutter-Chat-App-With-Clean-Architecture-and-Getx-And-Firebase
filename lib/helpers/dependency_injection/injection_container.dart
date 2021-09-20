import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_push_notification_proj/features/authentication/data/datasources/remote/auth_firebase_source.dart';
import 'package:flutter_push_notification_proj/features/authentication/data/datasources/remote/auth_firebase_source_Impl.dart';
import 'package:flutter_push_notification_proj/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/repositories/auth_repo.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/usecases/add_user_to_db_usecase.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/usecases/getToken_usecase.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/usecases/login_usecase.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:flutter_push_notification_proj/features/authentication/presentation/pages/controller/auth_controller.dart';
import 'package:flutter_push_notification_proj/features/chat/data/datasources/remote/message/user_messageList_remoute_source_impl.dart';
import 'package:flutter_push_notification_proj/features/chat/data/datasources/remote/message/user_message_list_remote_source.dart';
import 'package:flutter_push_notification_proj/features/chat/data/datasources/remote/user_list_firebase_remote_source.dart';
import 'package:flutter_push_notification_proj/features/chat/data/datasources/remote/userlist_firebase_remote_impl.dart';
import 'package:flutter_push_notification_proj/features/chat/data/repositories/user_messages_list_repo_impl.dart';
import 'package:flutter_push_notification_proj/features/chat/data/repositories/userlist_firebase_repo_impl.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/repositories/user_list_firebase_repo.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/repositories/user_list_messages_repo.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/usecases/add_message_usecase.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/usecases/get_userlist_firebase_usecase.dart';
import 'package:flutter_push_notification_proj/features/chat/presentation/pages/controller/chat_controller.dart';
import 'package:flutter_push_notification_proj/helpers/local_storage_shared_pref/local_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:get_it/get_it.dart';
// GetIt? sl = GetIt.instance;
// Future<void> initDI() async {
//   //Controllers:
//   sl!.registerLazySingleton<AuthController>(() => Get.put(AuthController(
//         loginUseCase: sl!.call(),
//         signUpUseCase: sl!.call(),
//       )));
// //USE CASES
//   //AUTH USE CASES
//   sl!.registerLazySingleton<LoginUseCase>(
//       () => LoginUseCase(repository: sl!.call()));
//   sl!.registerLazySingleton<SignUpUseCase>(
//       () => SignUpUseCase(repository: sl!.call()));
// //repository
//   sl!.registerLazySingleton<AuthenticationRepository>(() =>
//       AuthenticationRepositoryImplementation(
//           authFirebaseRemoteSource: sl!.call()));
//   //data source
//   sl!.registerLazySingleton<AuthFirebaseRemoteSource>(
//       () => AuthFirebaseSourceImpl(
//             auth: sl!.call(),
//           ));
//   //EXTERNAL:
//   final auth = FirebaseAuth.instance;
//   final fireStore = FirebaseFirestore.instance;
//   sl!.registerLazySingleton(() => auth);
//   sl!.registerLazySingleton(() => fireStore);
// }

Future<void> init() async {
  //CONTROLLERS
  Get.lazyPut<AuthController>(
    () => AuthController(
      loginUseCase: Get.find<LoginUseCase>(),
      signUpUseCase: Get.find<SignUpUseCase>(),
      tokenUseCase: Get.find<GetTokenUseCase>(),
      addUserToFirebase: Get.find<AddUserToFirebaseDbUseCase>(),
    ),
  );
  Get.lazyPut<ChatController>(() => ChatController(
        getUsersFromDB: Get.find<GetUserListFromFirebaseUseCase>(),
        addMessages: Get.find<AddMessageUseCase>(),
        getMessages: Get.find<GetMessagesUseCase>(),
      ));
  Get.lazyPut(() => ChatController());
  //USE CASES
  Get.lazyPut<LoginUseCase>(
    () => LoginUseCase(repository: Get.find<AuthenticationRepository>()),
  );
  Get.lazyPut<SignUpUseCase>(
    () => SignUpUseCase(repository: Get.find<AuthenticationRepository>()),
  );
  Get.lazyPut<GetTokenUseCase>(
    () => GetTokenUseCase(repository: Get.find<AuthenticationRepository>()),
  );
  Get.lazyPut<AddUserToFirebaseDbUseCase>(
    () => AddUserToFirebaseDbUseCase(
        repository: Get.find<AuthenticationRepository>()),
  );
  //Chat usecase:
  Get.lazyPut<GetUserListFromFirebaseUseCase>(() =>
      GetUserListFromFirebaseUseCase(
          repository: Get.find<UserListFirebaseRepository>()));
  Get.lazyPut<AddMessageUseCase>(() => AddMessageUseCase(
        userListMessagesRepo: Get.find<UserListMessagesRepo>(),
      ));

  Get.lazyPut<GetMessagesUseCase>(
      () => GetMessagesUseCase(repository: Get.find<UserListMessagesRepo>()));

  //REPOS
  Get.lazyPut<AuthenticationRepository>(
    () => AuthenticationRepositoryImplementation(
        authFirebaseRemoteSource: Get.find<AuthFirebaseRemoteSource>()),
  );

  Get.lazyPut<UserListFirebaseRepository>(() =>
      UserListFireBaseRepoImplementation(
          firebaseRemote: Get.find<UserListFirebaseRemoteSource>()));
  Get.lazyPut<UserListMessagesRepo>(() => UserMessagesListRepoImplementation(
      userMessageListRemoteSource: Get.find<UserMessageListRemoteSource>()));

  //DATA SOURCE
  Get.lazyPut<AuthFirebaseRemoteSource>(
    () => AuthFirebaseSourceImpl(
      auth: Get.find<FirebaseAuth>(),
      firebaseMessaging: Get.find<FirebaseMessaging>(),
      fireStore: Get.find<FirebaseFirestore>(),
    ),
  );

  //Chat Source
  Get.lazyPut<UserListFirebaseRemoteSource>(
    () => UserListFirebaseRemoteImplementation(
      fireStore: Get.find<FirebaseFirestore>(),
    ),
  );

  Get.lazyPut<UserMessageListRemoteSource>(
    () => UserMessageListRemoteSourceImplementation(
      firestore: Get.find<FirebaseFirestore>(),
    ),
  );
  Get.putAsync<SharedPreferences>(() => SharedPref.init());
  // Get.putAsync<SharedPreferences>(() => SharedPrefAuth.init());

//EXTERNAL
  final auth = FirebaseAuth.instance;
  final firebaseMessage = FirebaseMessaging.instance;
  final fireStore = FirebaseFirestore.instance;
  Get.put(auth, permanent: true);
  Get.put(fireStore, permanent: true);
  Get.put(firebaseMessage, permanent: true);
}
