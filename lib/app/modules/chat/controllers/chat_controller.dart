import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find<ChatController>();
  late String currentUserId;
  late String otherUserId;
  final isChatViewOpen = false.obs;
  @override
  void onInit() {
    super.onInit();
    isChatViewOpen.value = true;
  }

  @override
  void onClose() {
    isChatViewOpen.value = false;
  }

  String get chatId => currentUserId.hashCode <= otherUserId.hashCode
      ? '$currentUserId\_$otherUserId'
      : '$otherUserId\_$currentUserId';

  void initChat({required String current, required String other}) {
    currentUserId = current;
    otherUserId = other;
  }

  final List<Map<String, dynamic>> chatList = [
    {
      'user': "Customer 1",
      'msg': "how are you",
    },
    {
      'user': "Customer 1",
      'msg': "how are you",
    },
    {
      'user': "Customer 1",
      'msg': "how are you",
    },
    {
      'user': "Customer 1",
      'msg': "how are you",
    },
    {
      'user': "Customer 1",
      'msg': "how are you",
    },
  ];
}
