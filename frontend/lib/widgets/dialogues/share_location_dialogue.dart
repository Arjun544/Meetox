// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/mini_map.dart';

import '../../controllers/chat_controller.dart';
import '../../core/imports/core_imports.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';

class ShareLocationDialogue extends HookWidget {
  const ShareLocationDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    Future handleSendLocation() async {
      // if (conversationController.currentConversationId.value.isNotEmpty) {
      //   final msgObject = Message(
      //     id: getDocId(16),
      //     senderId: currentUser.value,
      //     message: currentUser.value.location!.address!,
      //     latitude: currentUser.value.location!.coordinates![0],
      //     longitude: currentUser.value.location!.coordinates![1],
      //     type: 'location',
      //     conversationId: conversationController.currentConversationId.value,
      //     createdAt: DateTime.now(),
      //     updatedAt: DateTime.now(),
      //   );

      //   await sendMessageMutation.mutateAsync({
      //     'msg': msgObject,
      //     'id': conversationController.currentConversationId.value,
      //   });

      //   if (sendMessageMutation.hasError) {
      //     log('mutation error: ${sendMessageMutation.error}');
      //     sendMessageMutation.reset();
      //   } else if (sendMessageMutation.hasData) {}
      // } else {
      //   final msgObject = Message(
      //     id: getDocId(16),
      //     senderId: currentUser.value,
      //     message: currentUser.value.location!.address!,
      //     latitude: currentUser.value.location!.coordinates![0],
      //     longitude: currentUser.value.location!.coordinates![1],
      //     type: 'location',
      //     createdAt: DateTime.now(),
      //     updatedAt: DateTime.now(),
      //   );

      //   await createConversationMutation.mutateAsync({
      //     'msg': msgObject,
      //     'type': type,
      //     'members': [currentUser.value.id!, user.id!],
      //   });

      //   if (createConversationMutation.hasError) {
      //     log('mutation error: ${createConversationMutation.error}');
      //     createConversationMutation.reset();
      //   } else if (createConversationMutation.hasData) {}
      // }
      Get.back();
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 200.h, horizontal: 15.w),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.theme.floatingActionButtonTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Share your location',
            style: context.theme.textTheme.headline5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 180.sp,
              width: Get.width,
              child: MiniMap(
                latitude: currentUser.value.location!.coordinates![0],
                longitude: currentUser.value.location!.coordinates![1],
              ),
            ),
          ),
          CustomButton(
            height: 50,
            width: Get.width * 0.5,
            text: 'Send',
            onPressed: () async => await handleSendLocation(),
          ),
        ],
      ),
    );
  }
}
