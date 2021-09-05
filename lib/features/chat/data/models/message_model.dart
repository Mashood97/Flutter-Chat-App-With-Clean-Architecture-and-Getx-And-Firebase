import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    final String? messageText,
    final String? senderId,
    final String? recieverId,
    final DateTime? dateTime,
  }) : super(
            dateTime: dateTime!,
            messageText: messageText!,
            senderId: senderId!,
            recieverId: recieverId!);

//This is where we define from json and to json methods.

  static MessageModel fromJson(DocumentSnapshot json) {
    DateTime dt = (json.get('datetime') as Timestamp).toDate();

    // var date = DateTime.fromMillisecondsSinceEpoch(json.get('datetime') * 1000);

    return MessageModel(
      senderId: json.get('senderId'),
      dateTime:dt,
      messageText: json.get('messageText'),
      recieverId: json.get('recieverId'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "datetime": dateTime,
      "messageText": messageText,
      "recieverId": recieverId,
    };
  }
}
