import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/conversation/mutations.dart';
import 'package:frontend/graphql/user/mutations.dart';
import 'package:frontend/graphql/user/queries.dart';
import 'package:frontend/helpers/get_distance.dart';
import 'package:frontend/models/conversation_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/chat_screen/chat_screen.dart';
import 'package:frontend/screens/followers_screen/followers_screen.dart';
import 'package:frontend/screens/user_profile_screen/user_profile_screen.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/online_indicator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserDetailsSheet extends HookWidget {
  const UserDetailsSheet(this.user, this.tappedUser, {super.key});
  final User user;
  final Rx<User> tappedUser;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapScreenController>();
    final followers = useState(user.followers!);

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

    final checkIsFollowed = useQuery(
      QueryOptions(
        document: gql(isFollowed),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "id": user.id,
        },
      ),
    );
    final followUser = useMutation(
      MutationOptions(
        document: gql(follow),
        onCompleted: (data) {
          if (data != null && data['follow'] != null) {
            followers.value += 1;
            checkIsFollowed.refetch();
          }
        },
      ),
    );
    final unFollowUser = useMutation(
      MutationOptions(
        document: gql(unFollow),
        onCompleted: (data) {
          if (data != null && data['unFollow'] != null) {
            followers.value -= 1;
            checkIsFollowed.refetch();
          }
        },
      ),
    );

    final checkHasConversation = useMutation(
      MutationOptions(
        document: gql(hasConversation),
        fetchPolicy: FetchPolicy.networkOnly,
        onCompleted: (data) {
          logSuccess(data!['hasConversation'].toString());
          final hasConversation = data['hasConversation']['hasConversation'];
          if (hasConversation) {
            final Conversation conversation =
                Conversation.fromJson(data['hasConversation']['conversation']);
            Get.to(() => ChatScreen(conversation: conversation));
          } else {
            Get.to(
              () => ChatScreen(
                  conversation: Conversation(
                id: null,
                participants: [user],
              )),
            );
          }
        },
      ),
    );

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
                          height: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
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
                      onTap: checkIsFollowed.result.isLoading ||
                              followUser.result.isLoading ||
                              unFollowUser.result.isLoading
                          ? () {}
                          : () async {
                              if (checkIsFollowed.result.data!['isFollowed']) {
                                unFollowUser.runMutation({
                                  "id": user.id,
                                });
                              } else {
                                followUser.runMutation({
                                  "id": user.id,
                                });
                              }
                            },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color:
                              checkIsFollowed.result.data?['isFollowed'] == null
                                  ? AppColors.primaryYellow
                                  : checkIsFollowed.result.data?['isFollowed']
                                      ? Colors.redAccent
                                      : AppColors.primaryYellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.sp,
                            vertical: 6.sp,
                          ),
                          child: checkIsFollowed.result.isLoading
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: AppColors.customBlack,
                                  size: 20.sp,
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      checkIsFollowed.result.data!['isFollowed']
                                          ? FlutterRemix.user_unfollow_fill
                                          : FlutterRemix.user_add_fill,
                                      size: 16.sp,
                                      color: context.theme.iconTheme.color,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      checkIsFollowed.result.data!['isFollowed']
                                          ? 'Unfollow'
                                          : 'Follow',
                                      style: context.theme.textTheme.labelSmall,
                                    ),
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
                      Get.to(() => FollowersScreen(user, false));
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
                      Get.to(() => FollowersScreen(user, true));
                    },
                    child: Column(
                      children: [
                        Text(
                          user.followings.toString(),
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
                          color: context.theme.indicatorColor,
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
                        onTap: checkHasConversation.result.isLoading
                            ? () {}
                            : () {
                                checkHasConversation.runMutation({
                                  'sender': user.id,
                                  'receiver': currentUser.value.id,
                                });
                              },
                        child: Container(
                          height: 45.sp,
                          width: 50.sp,
                          padding: EdgeInsets.symmetric(
                              horizontal: checkHasConversation.result.isLoading
                                  ? 25.w
                                  : 0),
                          decoration: BoxDecoration(
                            color: context.theme.indicatorColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: checkHasConversation.result.isLoading
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: AppColors.primaryYellow,
                                  size: 20.w,
                                )
                              : Icon(
                                  FlutterRemix.chat_3_fill,
                                  size: 22.sp,
                                  color: context.theme.iconTheme.color,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => UserProfileScreen(
                              user: user, followers: followers),
                        ),
                        child: Container(
                          height: 45.sp,
                          decoration: BoxDecoration(
                            color: context.theme.indicatorColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            FlutterRemix.user_4_fill,
                            size: 22.sp,
                            color: context.theme.iconTheme.color,
                          ),
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
