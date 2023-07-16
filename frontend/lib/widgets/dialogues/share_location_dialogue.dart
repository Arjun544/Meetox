// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/message/mutations.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/loaders/botton_loader.dart';
import 'package:frontend/widgets/mini_map.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../controllers/chat_controller.dart';
import '../../core/imports/core_imports.dart';

class ShareLocationDialogue extends HookWidget {
  const ShareLocationDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();

    final sendMessageMutation = useMutation(
      MutationOptions(
        document: gql(sendMessage),
        onCompleted: (data) {
          if (data != null && data['sendMessage'] != null) {
            logSuccess(data.toString());
            Get.back();
          }
        },
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 200.h, horizontal: 15.w),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.theme.floatingActionButtonTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Share your location',
            style: context.theme.textTheme.labelMedium,
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
          sendMessageMutation.result.isLoading
              ? ButtonLoader(
                  height: 40.h,
                  width: Get.width * 0.4,
                )
              : CustomButton(
                  height: 40.h,
                  width: Get.width * 0.4,
                  text: 'Send',
                  onPressed: () => sendMessageMutation.runMutation(
                    {
                      'id': controller.conversation.value.id,
                      'message': currentUser.value.location!.address!,
                      'type': 'location',
                      'latitude': currentUser.value.location!.coordinates![0],
                      'longitude': currentUser.value.location!.coordinates![1],
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
