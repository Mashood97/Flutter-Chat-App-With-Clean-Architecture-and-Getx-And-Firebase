import 'package:flutter_push_notification_proj/features/chat/domain/entities/message.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/repositories/user_list_messages_repo.dart';

class GetMessagesUseCase {
  final UserListMessagesRepo repository;
  GetMessagesUseCase({required this.repository});

  Stream<List<Message>> call() {
    return repository.getAllMessages();
  }
}
