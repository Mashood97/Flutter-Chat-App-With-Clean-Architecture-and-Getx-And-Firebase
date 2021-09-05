class Message {
  final String messageText;
  final String senderId;
  final String recieverId;
  final DateTime dateTime;

  Message({
    required this.dateTime,
    required this.messageText,
    required this.recieverId,
    required this.senderId,
  });
}
