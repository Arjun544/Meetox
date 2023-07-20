import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/models/message_model.dart';
import 'package:frontend/widgets/unfocuser.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../../models/conversation_model.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/loaders/chat_loader.dart';
import 'components/chat_bubble.dart';
import 'components/chat_header.dart';
import 'components/message_input.dart';

class ChatScreen extends GetView<ChatController> {
  final Conversation conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    controller.conversation(conversation);

    return UnFocuser(
      child: Scaffold(
        appBar: chatHeader(context),
        body: Obx(
          () => controller.conversation.value.id == null
              ? Center(
                  child: CustomErrorWidget(
                    image: AssetsManager.sadState,
                    text: 'No messages',
                    isWarining: true,
                    onPressed: () {},
                  ),
                )
              : PagedListView(
                  pagingController: controller.pagingController,
                  reverse: true,
                  scrollController: controller.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  builderDelegate: PagedChildBuilderDelegate<Message>(
                    animateTransitions: true,
                    transitionDuration: const Duration(milliseconds: 500),
                    firstPageProgressIndicatorBuilder: (_) =>
                        const ChatLoader(),
                    newPageProgressIndicatorBuilder: (_) => const ChatLoader(),
                    firstPageErrorIndicatorBuilder: (_) => Center(
                      child: CustomErrorWidget(
                        image: AssetsManager.angryState,
                        text: 'Failed to fetch messages',
                        onPressed: () => controller.pagingController.refresh(),
                      ),
                    ),
                    newPageErrorIndicatorBuilder: (_) => Center(
                      child: CustomErrorWidget(
                        image: AssetsManager.angryState,
                        text: 'Failed to fetch messages',
                        onPressed: () => controller.pagingController.refresh(),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => CustomErrorWidget(
                      image: AssetsManager.sadState,
                      text: 'No messages',
                      onPressed: () => controller.pagingController.refresh(),
                    ),
                    itemBuilder: (context, item, index) => ChatBubble(
                      msg: item,
                    ),
                  ),
                ),
        ),
        floatingActionButton: Obx(
          () => Visibility(
            visible: controller.hasScrolledUp.value,
            child: FloatingActionButton.small(
              elevation: 1,
              onPressed: () => controller.scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
              backgroundColor: context.theme.scaffoldBackgroundColor,
              child: Icon(
                FlutterRemix.arrow_down_s_fill,
                color: context.theme.iconTheme.color,
              ),
            ),
          ),
        ),
        bottomNavigationBar: const MessageInput(),
      ),
    );
  }
}
