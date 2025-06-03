import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/util/custom_appbar.dart';
import 'package:vehicle_booking/app/modules/chat/controllers/chat_controller.dart';
import 'package:vehicle_booking/app/modules/chat/views/chat_view.dart';

class ChatListView extends StatelessWidget {
  ChatListView({super.key});
  final ChatController controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'All Chats'),
      body: ListView.builder(
        itemCount: controller.chatList.length,
        itemBuilder: (context, index) {
          final chat = controller.chatList[index];

          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(chat['user']),
            subtitle: Text(chat['msg']),
            onTap: () {
              Get.to(() => ChatView(
                    currentUserId: 'currentUserId',
                    otherUserId: 'customerId',
                    otherUserName: 'Customer',
                  ));
            },
          );
        },
      ),
    );
  }
}
