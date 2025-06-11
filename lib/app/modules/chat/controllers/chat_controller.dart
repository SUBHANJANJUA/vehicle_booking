import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }
}
