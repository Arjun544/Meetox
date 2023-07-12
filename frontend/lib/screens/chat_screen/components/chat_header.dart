import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/online_indicator.dart';

import '../../../core/imports/packages_imports.dart';
import '../../../models/user_model.dart';

AppBar chatHeader(BuildContext context) {
  final ChatController chatController = Get.find();
  final RxBool isTyping = false.obs;
  final User receiver = chatController.conversation.value.participants![0];

  return AppBar(
    elevation: 0,
    backgroundColor: context.theme.scaffoldBackgroundColor,
    title: Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 18.sp,
              backgroundColor: AppColors.primaryYellow,
              foregroundImage: CachedNetworkImageProvider(
                  receiver.displayPic!.profile == ''
                      ? profilePlaceHolder
                      : receiver.displayPic!.profile!),
            ),
            OnlineIndicator(id: receiver.id!),
          ],
        ),
        SizedBox(width: 20.sp),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              receiver.name == '' ? 'Unknown' : receiver.name!,
              style: context.theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 2),
            Obx(
              () => Text(
                isTyping.value ? 'typing...' : 'Tap to view profile',
                style: context.theme.textTheme.labelSmall!
                    .copyWith(fontSize: 10, color: Colors.blue),
              ),
            ),
          ],
        ),
      ],
    ),
    leading: GestureDetector(
      onTap: () => Get.back(),
      child: const Icon(Icons.arrow_back_ios_new_rounded),
    ),
  );
}
