import 'package:flutter_push_notification_proj/features/chat/domain/entities/message.dart';

abstract class UserMessageListRemoteSource {
  Stream<List<Message>> getAllMessages();
  Future<void> addAMessage({Message? messageEntity});
}
