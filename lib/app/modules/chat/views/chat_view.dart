import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/util/chat_bubble_widget.dart';
import 'package:vehicle_booking/app/data/util/custom_appbar.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final String currentUserId;
  final String otherUserId;
  final String otherUserName;

  ChatView({
    required this.currentUserId,
    required this.otherUserId,
    required this.otherUserName,
  });

  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final chatId = currentUserId.hashCode <= otherUserId.hashCode
        ? '$currentUserId\_$otherUserId'
        : '$otherUserId\_$currentUserId';

    final ChatController controller = Get.find(tag: chatId);
    controller.initChat(current: currentUserId, other: otherUserId);

    // final TextEditingController messageController = TextEditingController();
    // final ScrollController _scrollController = ScrollController();

    // @override
    // Widget build(BuildContext context) {
    //   Get.put(ChatController());
    //   controller.initChat(current: currentUserId, other: otherUserId);

    return Scaffold(
      appBar: CustomAppBar(title: otherUserName),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              // 👇 Add auto-scroll after new messages are added
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.jumpTo(
                    _scrollController.position.maxScrollExtent,
                  );
                }
              });

              return ListView.builder(
                controller: _scrollController, // 👈 attach controller
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isUser = msg['senderId'] == controller.currentUserId;

                  return ChatBubbleWidget(
                    message: msg['text'],
                    isUser: isUser,
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final text = messageController.text;
                    messageController.clear();

                    await controller
                        .sendMessage(text); // ✅ wait until message is stored

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      }
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
