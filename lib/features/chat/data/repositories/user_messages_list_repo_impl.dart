import 'package:flutter_push_notification_proj/features/chat/data/datasources/remote/message/user_message_list_remote_source.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/entities/message.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/repositories/user_list_messages_repo.dart';

class UserMessagesListRepoImplementation implements UserListMessagesRepo {
  UserMessageListRemoteSource userMessageListRemoteSource;
  UserMessagesListRepoImplementation(
      {required this.userMessageListRemoteSource});
  @override
  Future<void> addAMessage({Message? messageEntity}) =>
      userMessageListRemoteSource.addAMessage(messageEntity: messageEntity!);

  @override
  Stream<List<Message>> getAllMessages() =>
      userMessageListRemoteSource.getAllMessages();
}
