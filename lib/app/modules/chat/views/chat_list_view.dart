import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/util/custom_appbar.dart';
import 'package:vehicle_booking/app/modules/chat/controllers/chat_controller.dart';
import 'package:vehicle_booking/app/modules/chat/views/chat_view.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';

class ChatListView extends StatelessWidget {
  ChatListView({super.key});
  final ChatController controller = Get.put(ChatController());
  final SignupController signupcontroller = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'All Chats',
        actionWidget: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            final uid = signupcontroller.userModel.value?.uid;
            if (uid != null) {
              controller.loadChatPreviews(uid);
            }
          },
        ),
      ),
      body: Obx(() {
        final chats = controller.chatPreviewList;

        if (chats.isEmpty) {
          return const Center(
            child: Text(
              'No chats found.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];

            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(chat['otherUserName']),
              subtitle: Text(chat['lastMessage'] ?? ''),
              onTap: () {
                final currentUid = signupcontroller.userModel.value?.uid ?? '';
                final otherUid = chat['otherUserId'];
                final chatId = currentUid.hashCode <= otherUid.hashCode
                    ? '$currentUid\_$otherUid'
                    : '$otherUid\_$currentUid';

                Get.to(
                    () => ChatView(
                          currentUserId: currentUid,
                          otherUserId: otherUid,
                          otherUserName: chat['otherUserName'],
                        ), binding: BindingsBuilder(() {
                  Get.put(ChatController(),
                      tag: chatId); // 💡 isolated instance
                }));
              },
            );
          },
        );
      }),
    );
  }
}
