import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_push_notification_proj/features/chat/data/datasources/remote/message/user_message_list_remote_source.dart';
import 'package:flutter_push_notification_proj/features/chat/data/models/message_model.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/entities/message.dart';

class UserMessageListRemoteSourceImplementation
    implements UserMessageListRemoteSource {
  final FirebaseFirestore firestore;
  UserMessageListRemoteSourceImplementation({required this.firestore});
  @override
  Future<void> addAMessage({Message? messageEntity}) async {
    final messageCollectionRef = firestore.collection("Messages");
    var messageId = messageCollectionRef.doc().id;

    messageCollectionRef.doc(messageId).get().then((message) {
      final newMessage = MessageModel(
        dateTime: messageEntity!.dateTime,
        messageText: messageEntity.messageText,
        recieverId: messageEntity.recieverId,
        senderId: messageEntity.senderId,
      ).toJson();

      if (!message.exists) {
        messageCollectionRef.doc(messageId).set(newMessage);
      }
      return;
    });
  }

  @override
  Stream<List<Message>> getAllMessages() {
    final messages = firestore.collection("Messages");

    return messages.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => MessageModel.fromJson(docSnap))
          .toList();
    });
  }
}
