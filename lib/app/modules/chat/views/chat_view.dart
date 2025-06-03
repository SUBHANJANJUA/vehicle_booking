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

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    controller.initChat(current: currentUserId, other: otherUserId);

    return Scaffold(
      appBar: CustomAppBar(title: otherUserName),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ChatBubbleWidget(
                  message: " msg.text",
                  isUser: true,
                  // isUser: msg.senderId == currentUserId,
                ),
                ChatBubbleWidget(
                  message: " msg.text",
                  isUser: false,
                  // isUser: msg.senderId == currentUserId,
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: Obx(() => ListView.builder(
          //         reverse: true,
          //         itemCount: controller.messages.length,
          //         itemBuilder: (context, index) {
          //           final msg = controller.messages[index];
          // return ChatBubbleWidget(
          //   message: msg.text,
          //   isUser: msg.senderId == currentUserId,
          // );
          //         },
          //       )),
          // ),
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
                  onPressed: () {
                    // controller.sendMessage(messageController.text);
                    messageController.clear();
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
