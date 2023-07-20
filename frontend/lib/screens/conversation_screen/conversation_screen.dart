import 'package:frontend/controllers/conversation_controller.dart';
import 'package:frontend/models/conversation_model.dart';
import 'package:frontend/widgets/custom_error_widget.dart';
import 'package:frontend/widgets/custom_field.dart';
import 'package:frontend/widgets/top_bar.dart';
import 'package:frontend/widgets/unfocuser.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../../graphql/conversation/subscriptions.dart';
import '../../widgets/loaders/circles_loader.dart';
import 'components/conversation_tile.dart';

class ConversationScreen extends GetView<ConversationController> {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ConversationController());

    return UnFocuser(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 140,
              elevation: 0,
              floating: false,
              pinned: true,
              snap: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 15.sp, left: 15.sp, bottom: 10),
                  child: SizedBox(
                    height: 40.h,
                    child: CustomField(
                      hintText: 'Search',
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      isPasswordVisible: true.obs,
                      hasFocus: false.obs,
                      autoFocus: false,
                      isSearchField: true,
                      keyboardType: TextInputType.text,
                      prefixIcon: FlutterRemix.search_2_fill,
                      onChanged: (value) => controller.searchQuery(value),
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: TopBar(
                    isPrecise: false.obs,
                    topPadding: 0,
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: RefreshIndicator(
                backgroundColor: context.theme.scaffoldBackgroundColor,
                color: AppColors.primaryYellow,
                onRefresh: () async =>
                    controller.conversationsPagingController.refresh(),
                child: PagedListView(
                  pagingController: controller.conversationsPagingController,
                  padding: EdgeInsets.only(top: 10.h, right: 15.w, left: 15.w),
                  builderDelegate: PagedChildBuilderDelegate<Conversation>(
                    animateTransitions: true,
                    transitionDuration: const Duration(milliseconds: 500),
                    firstPageProgressIndicatorBuilder: (_) =>
                        const CirclesLoader(),
                    newPageProgressIndicatorBuilder: (_) =>
                        const CirclesLoader(),
                    firstPageErrorIndicatorBuilder: (_) => CustomErrorWidget(
                      image: AssetsManager.angryState,
                      text: 'Failed to fetch conversations',
                      onPressed: () =>
                          controller.conversationsPagingController.refresh(),
                    ),
                    newPageErrorIndicatorBuilder: (_) => Center(
                      child: Center(
                        heightFactor: 2.h,
                        child: CustomErrorWidget(
                          image: AssetsManager.angryState,
                          text: 'Failed to fetch conversations',
                          onPressed: () => controller
                              .conversationsPagingController
                              .refresh(),
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => Center(
                      heightFactor: 3.h,
                      child: CustomErrorWidget(
                        image: AssetsManager.sadState,
                        text: 'No conversations found',
                        isWarining: true,
                        onPressed: () {},
                      ),
                    ),
                    itemBuilder: (context, item, index) => Subscription(
                      options: SubscriptionOptions(
                        document: gql(connversationUpdated),
                        variables: {'id': item.id!},
                        parserFn: (data) => Conversation.fromJson(
                          data['conversationUpdated'] as Map<String, dynamic>,
                        ),
                      ),
                      onSubscriptionResult: (subscriptionResult, client) {
                        if (subscriptionResult.hasException) {
                          logError(subscriptionResult.exception.toString());
                          return;
                        } else {
                          controller.conversationsPagingController.itemList!
                              .removeWhere((element) =>
                                  element.id ==
                                  subscriptionResult.parsedData!.id);

                          controller.conversationsPagingController.itemList!
                              .insert(0, subscriptionResult.parsedData!);
                          controller.conversationsPagingController
                              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                              .notifyListeners();
                        }
                      },
                      builder: (context) {
                        return ConversationTile(
                          conversation: item,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // floatingActionButton: Padding(
        //   padding: EdgeInsets.only(bottom: Platform.isIOS ? 100.sp : 80.sp),
        //   child: FloatingActionButton(
        //     heroTag: 'Conversations fab',
        //     onPressed: () => showCustomSheet(
        //       context: context,
        //       child: NewConversationScreen(),
        //     ),
        //     child: Icon(
        //       FlutterRemix.chat_new_fill,
        //       color: context.theme.appBarTheme.iconTheme!.color,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
