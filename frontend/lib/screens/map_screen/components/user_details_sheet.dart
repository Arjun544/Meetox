import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/helpers/get_distance.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/online_indicator.dart';

class UserDetailsSheet extends HookWidget {
  const UserDetailsSheet(this.user, this.tappedUser, {super.key});
  final User user;
  final Rx<User> tappedUser;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapScreenController>();
    final followers = useState(user.followers!.length);

    // final followMutation = useMutation(job: FollowersQueries.followMutation);
    // final unfollowMutation =
    //     useMutation(job: FollowersQueries.unfollowMutataion);

    // final ValueNotifier<bool> isFetchingConversations = useState(false);

    final currentLatitude =
        controller.rootController.currentPosition.value.latitude;
    final currentLongitude =
        controller.rootController.currentPosition.value.longitude;
    final userLatitude = user.location!.coordinates![0];
    final userLongitude = user.location!.coordinates![1];

    final distanceBtw = getDistance(
      currentLatitude,
      currentLongitude,
      userLatitude,
      userLongitude,
    );

    // Future handleFollow() async {
    //   await followMutation.mutateAsync({
    //     'to': user.id,
    //   });

    //   if (followMutation.hasError) {
    //     log('mutation error: ${followMutation.error}');
    //     showToast('Request failed');
    //     followMutation.reset();
    //   } else if (followMutation.hasData) {
    //     followers.value += 1;
    //     currentUser.value.followings!.add(user.id!);
    //   }
    // }

    // Future handleUnfollow() async {
    //   await unfollowMutation.mutateAsync({
    //     'to': user.id,
    //   });
    //   if (unfollowMutation.hasError) {
    //     log('mutation error: ${unfollowMutation.error}');
    //     showToast('Request failed');
    //     unfollowMutation.reset();
    //   } else if (unfollowMutation.hasData) {
    //     followers.value -= 1;
    //     currentUser.value.followings!.remove(user.id!);
    //   }
    // }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.animatedMapMove(
        LatLng(
          user.location!.coordinates![0],
          user.location!.coordinates![1],
        ),
        14,
      );
    });
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            controller.isFiltersVisible.value = true;
            tappedUser.value = User();
            Navigator.pop(context);
          },
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.transparent,
          ),
        ),
        Container(
          width: Get.width,
          margin: EdgeInsets.only(top: Get.height * 0.55),
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  height: 5.sp,
                  width: 70.sp,
                  decoration: BoxDecoration(
                    color:
                        context.theme.bottomNavigationBarTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 16,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              imageUrl: user.displayPic!.profile!.isEmpty
                                  ? profilePlaceHolder
                                  : user.displayPic!.profile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        OnlineIndicator(
                          id: user.id!,
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    user.name == '' ? 'Unknown' : user.name!.capitalizeFirst!,
                    style: context.theme.textTheme.labelMedium,
                  ),
                  subtitle: Text(
                    user.location?.address?.capitalizeFirst ?? 'Unknown',
                    style: context.theme.textTheme.labelSmall!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () async {},
                      // currentUser.value.followings!.contains(user.id)
                      //     ? await handleUnfollow()
                      //     : await handleFollow(),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.primaryYellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.sp,
                            vertical: 6.sp,
                          ),
                          child: true == true
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: AppColors.customBlack,
                                  size: 20.sp,
                                )
                              : const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Icon(
                                    //   currentUser.value.followings!
                                    //           .contains(user.id)
                                    //       ? FlutterRemix.user_unfollow_fill
                                    //       : FlutterRemix.user_add_fill,
                                    //   size: 16.sp,
                                    //   color: context.theme.iconTheme.color,
                                    // ),
                                    SizedBox(width: 8),
                                    // Text(
                                    //   currentUser.value.followings!
                                    //           .contains(user.id)
                                    //       ? 'Unfollow'
                                    //       : 'Follow',
                                    //   style:
                                    //       context.theme.textTheme.headline6,
                                    // ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      // final FollowersScreenController
                      //     followersScreenController =
                      //     Get.put(FollowersScreenController());
                      // followersScreenController.selectedUserId.value = user.id!;
                      // Get.to(() => FollowersScreen(user));
                      // followersScreenController.tabController.animateTo(0);
                    },
                    child: Column(
                      children: [
                        Text(
                          followers.value.toString(),
                          style: context.theme.textTheme.labelMedium,
                        ),
                        Text(
                          'Followers',
                          style: context.theme.textTheme.labelSmall!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // final FollowersScreenController
                      //     followersScreenController =
                      //     Get.put(FollowersScreenController());
                      // Get.to(() => FollowersScreen(user));
                      // followersScreenController.tabController.animateTo(1);
                    },
                    child: Column(
                      children: [
                        Text(
                          user.followings!.length.toString(),
                          style: context.theme.textTheme.labelMedium,
                        ),
                        Text(
                          'Followings',
                          style: context.theme.textTheme.labelSmall!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 45.sp,
                        decoration: BoxDecoration(
                          color: context.theme.bottomSheetTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FlutterRemix.pin_distance_fill,
                              size: 22.sp,
                              color: context.theme.iconTheme.color,
                            ),
                            Text(
                              '~ ${distanceBtw.toStringAsFixed(0)} KMs',
                              style: context.theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          // Fetches user conversations and checks if any conversation is available with this user
                          // isFetchingConversations.value = true;
                          // final List<Conversation> conversations =
                          //     await ConversationServices.getConversations();
                          // isFetchingConversations.value = false;

                          // final Conversation conversation =
                          //     conversations.firstWhere(
                          //         (conversation) =>
                          //             conversation.members!.contains(user),
                          //         orElse: () => Conversation());

                          // if (isFetchingConversations.value == false &&
                          //     conversation.id != null) {
                          //   final ConversationController
                          //       conversationController =
                          //       Get.put(ConversationController());
                          //   conversationController.currentConversationId.value =
                          //       conversation.id!;

                          //   await Get.to(
                          //     () => ChatScreen(
                          //       user: user,
                          //       conversation: conversation,
                          //     ),
                          //   );
                          // } else {
                          //   await Get.to(
                          //     () => ChatScreen(
                          //       user: user,
                          //       conversation: Conversation(type: 'private'),
                          //     ),
                          //   );
                          // }
                        },
                        child: Container(
                          height: 45.sp,
                          width: 50.sp,
                          decoration: BoxDecoration(
                            color:
                                context.theme.bottomSheetTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            FlutterRemix.chat_smile_2_fill,
                            size: 22.sp,
                            color: context.theme.iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 45.sp,
                        decoration: BoxDecoration(
                          color: context.theme.bottomSheetTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          FlutterRemix.profile_fill,
                          size: 22.sp,
                          color: context.theme.iconTheme.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.sp,
                width: Get.width,
                margin:
                    EdgeInsets.only(right: 15.sp, left: 15.sp, bottom: 15.sp),
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FlutterRemix.treasure_map_fill,
                      size: 18.sp,
                      color: context.theme.iconTheme.color,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Navigate',
                      style: context.theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
