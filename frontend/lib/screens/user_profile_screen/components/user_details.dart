import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/user/mutations.dart';
import 'package:frontend/graphql/user/queries.dart';
import 'package:frontend/helpers/get_social.dart';
import 'package:frontend/helpers/launch_url.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/followers_screen/followers_screen.dart';
import 'package:frontend/widgets/custom_tabbar.dart';
import 'package:frontend/widgets/loaders/socials_loaders.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserDetails extends HookWidget {
  final User user;
  final TabController tabController;
  final ValueNotifier<int> followers;

  const UserDetails(this.user, this.tabController, this.followers, {super.key});

  @override
  Widget build(BuildContext context) {
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
    final getSocials = useQuery<List<Social>>(
      QueryOptions(
        document: gql(socials),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "id": user.id,
        },
        // parserFn: (data) =>
        //     List<Social>.from(data["socials"]!.map((x) => Social.fromJson(x))),
      ),
    );

    return SliverAppBar(
      elevation: 0.1,
      expandedHeight: Get.height * 0.37,
      collapsedHeight: 100,
      pinned: true,
      title: Text(
        user.name!.capitalizeFirst!,
        style: context.theme.textTheme.labelMedium,
      ),
      bottom: PreferredSize(
        preferredSize: Size(Get.width, 0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: CustomTabbar(
            controller: tabController,
            tabs: const [
              Text('Info'),
              Text('Feeds'),
            ],
            onTap: (int value) {},
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(top: Get.height * 0.15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: Get.height * 0.09,
                    width: Get.width * 0.18,
                    decoration: BoxDecoration(
                      color: context.theme.indicatorColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          user.displayPic!.profile!,
                        ),
                      ),
                    ),
                  ),
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
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment:
                    getSocials.result.data?['socials'].isEmpty ?? false
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
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
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              checkIsFollowed.result.data?['isFollowed'] ??
                                      false
                                  ? FlutterRemix.user_unfollow_fill
                                  : FlutterRemix.user_add_fill,
                              size: 16.sp,
                              color: context.theme.iconTheme.color,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              checkIsFollowed.result.data?['isFollowed'] ??
                                      false
                                  ? 'Unfollow'
                                  : 'Follow',
                              style: context.theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  getSocials.result.isLoading
                      ? const SocialsLoaders()
                      : getSocials.result.data!['socials'].isEmpty
                          ? const SizedBox.shrink()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: getSocials.result.data!['socials']
                                  .map<Widget>(
                                    (social) => InkWell(
                                      onTap: () => appLaunchUrl(social['url']),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: context.theme.indicatorColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            getSocial(social['name']),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
