import 'package:flutter/cupertino.dart';
import 'package:flutter_push_notification_proj/features/authentication/data/datasources/local/auth_local_sharedpref.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/entities/message.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/entities/user.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/usecases/add_message_usecase.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/usecases/get_userlist_firebase_usecase.dart';
import 'package:flutter_push_notification_proj/helpers/constant/constant_method.dart';
import 'package:flutter_push_notification_proj/helpers/routing/app_route.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  GetUserListFromFirebaseUseCase? _getUsersFromDB;
  AddMessageUseCase? _addMessageUseCase;
  GetMessagesUseCase? _getMessagesUseCase;

  ChatController({
    getUsersFromDB: GetUserListFromFirebaseUseCase,
    getMessages: GetMessagesUseCase,
    addMessages: AddMessageUseCase,
    // signUpUseCase: SignUpUseCase,
  }) {
    this._getUsersFromDB = getUsersFromDB;
    this._addMessageUseCase = addMessages;
    this._getMessagesUseCase = getMessages;
  }

  final _messageText = TextEditingController();
  TextEditingController get messageTextCont => _messageText;

  RxList<UserEntity> _usersList = RxList();

  List<UserEntity> get usersList => [..._usersList];

  RxBool _isBusy = false.obs;

  bool get isBusy => _isBusy.value;

  setBusy(bool? isBusy) {
    _isBusy.value = isBusy!;
  }

  Future<void> getAllUserFromDB() async {
    try {
      _usersList.clear();
      await SharedPrefAuth.init();
      var email = await SharedPrefAuth.getEmailOfUser();
      setBusy(true);
      List<UserEntity> _users = await _getUsersFromDB!.call();
      _users.forEach((user) {
        if (user.email == email) {
          return;
        }
        _usersList.add(user);
      });
      setBusy(false);
    } catch (e) {
      setBusy(false);
      ConstantMethod.showErrorSnackBar(e.toString());
    }
  }

  logoutUser() async {
    await SharedPrefAuth.init();
    SharedPrefAuth.logoutUser();
    Get.offAndToNamed(PageConst.login);
  }

  String? _getCurrentUserId = '';
  String? get currentUserId => _getCurrentUserId;

  String? _getFriendUserId = '';
  String? get friendUserId => _getFriendUserId;

  RxList<Message> _messagesList = RxList<Message>();

  List<Message> get messagesList => _messagesList;

  getMessagesListFromDB() {
    _messagesList.bindStream(_getMessagesUseCase!.call());
    // _messagesList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  Future<void> addAMessageToDB({Message? messageVal}) async {
    try {
      final message = Message(
        senderId: messageVal!.senderId,
        dateTime: messageVal.dateTime,
        messageText: messageVal.messageText,
        recieverId: messageVal.recieverId,
      );
      await _addMessageUseCase!.call(message: message);
      // _messagesList.reversed;

      _messageText.clear();
    } catch (e) {
      ConstantMethod.showErrorSnackBar(e.toString());
    }
  }

  getFriendsId() async {
    _getFriendUserId = Get.arguments as String?;
  }

  @override
  void onInit() async {
    await getAllUserFromDB();
    await SharedPrefAuth.init();
    _getCurrentUserId = await SharedPrefAuth.getUserID();

    getMessagesListFromDB();

    super.onInit();
  }
}
