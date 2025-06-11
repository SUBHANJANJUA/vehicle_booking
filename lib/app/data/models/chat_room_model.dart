import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String chatId;
  final List<String> users; // exactly two UIDs
  final String lastMessage;
  final Timestamp timestamp;

  ChatRoomModel({
    required this.chatId,
    required this.users,
    required this.lastMessage,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'users': users,
        'lastMessage': lastMessage,
        'timestamp': timestamp,
      };

  factory ChatRoomModel.fromJson(Map<String, dynamic> json, String id) {
    return ChatRoomModel(
      chatId: id,
      users: List<String>.from(json['users']),
      lastMessage: json['lastMessage'] ?? '',
      timestamp: json['timestamp'],
    );
  }
}

class MessageModel {
  final String senderId;
  final String receiverId;
  final String text;
  final Timestamp timestamp;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
        'timestamp': timestamp,
      };

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      text: json['text'],
      timestamp: json['timestamp'],
    );
  }
}
