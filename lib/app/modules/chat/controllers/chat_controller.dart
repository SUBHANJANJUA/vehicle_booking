import 'dart:convert';
// import 'dart:developer';
import 'package:googleapis_auth/auth_io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  void initChat({required String current, required String other}) {
    currentUserId = current;
    otherUserId = other;

    // Always listen when ChatView opens
    if (!_isListening) {
      _isListening = true;
      listenToMessages();
    }
  }

  RxList<Map<String, dynamic>> chatPreviewList = <Map<String, dynamic>>[].obs;

  Future<void> sendPushNotificationV1({
    required String targetToken,
    required String senderName,
    required String message,
  }) async {
    final accessToken = await FcmTokenManager.getAccessToken();

    final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/vehiclebooking-98c8a/messages:send');

    final body = {
      "message": {
        "token": targetToken,
        "notification": {
          "title": senderName,
          "body": message,
        },
        "data": {
          "type": "chat",
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
        }
      }
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print("✅ Notification sent successfully.");
    } else {
      print("❌ Failed to send notification: ${response.body}");
    }
  }

  void loadChatPreviews(String userId) {
    firestore
        .collection('chats')
        .where('users', arrayContains: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) async {
      List<Map<String, dynamic>> enrichedChats = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();

        // Find the other user's UID
        final List<dynamic> users = data['users'];
        final otherUserId = users.firstWhere((u) => u != userId);

        // Fetch other user's name from Firestore
        final userDoc =
            await firestore.collection('users').doc(otherUserId).get();
        final otherUserName = userDoc.data()?['name'] ?? 'Unknown';

        enrichedChats.add({
          'chatId': doc.id,
          'otherUserId': otherUserId,
          'otherUserName': otherUserName,
          'lastMessage': data['lastMessage'],
          'timestamp': data['timestamp'],
        });
      }

      chatPreviewList.value = enrichedChats;
    });
  }

  @override
  void onInit() {
    super.onInit();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      loadChatPreviews(uid);
    }
  }

  static ChatController get to => Get.find<ChatController>();

  late String currentUserId;
  late String otherUserId;

  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get chatId => currentUserId.hashCode <= otherUserId.hashCode
      ? '$currentUserId\_$otherUserId'
      : '$otherUserId\_$currentUserId';

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final msg = {
      'senderId': currentUserId,
      'receiverId': otherUserId,
      'text': text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    final chatRef = firestore.collection('chats').doc(chatId);

    // Step 1: Ensure parent chat document exists
    await chatRef.set({
      'users': [currentUserId, otherUserId],
      'lastMessage': text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // Step 2: Add the message
    await chatRef.collection('messages').add(msg);

    // Step 3: Trigger listener if it's first message
    if (!_isListening) {
      _isListening = true;
      listenToMessages();
    }
    final receiverDoc =
        await firestore.collection('users').doc(otherUserId).get();
    final receiverToken = receiverDoc.data()?['fcmToken'];

// Optional: Get sender name
    final senderDoc =
        await firestore.collection('users').doc(currentUserId).get();
    final senderName = senderDoc.data()?['name'] ?? 'New Message';

    if (receiverToken != null) {
      await sendPushNotificationV1(
        targetToken: receiverToken,
        senderName: senderName,
        message: text.trim(),
      );
    }
  }

  bool _isListening = false;

  void listenToMessages() {
    firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs
          // ignore: unnecessary_cast
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }
}

class FcmTokenManager {
  static Future<String> getAccessToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final accountCredentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "vehiclebooking-98c8a",
      "private_key_id": "YOUR_PRIVATE_KEY_ID",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nYOUR_KEY\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-fbsvc@vehiclebooking-98c8a.iam.gserviceaccount.com",
      "client_id": "117559121866140831515",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40vehiclebooking-98c8a.iam.gserviceaccount.com"
    });

    final client = await clientViaServiceAccount(accountCredentials, scopes);
    final token = client.credentials.accessToken.data;
    client.close();
    return token;
  }
}
