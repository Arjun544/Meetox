import 'package:frontend/graphql/user/mutations.dart';
import 'package:frontend/graphql/user/queries.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/online_indicator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';

class FollowerTile extends HookWidget {
  final User user;
  final bool showFollowButton;
  final VoidCallback? onTap;

  const FollowerTile(
      {super.key,
      required this.user,
      this.showFollowButton = true,
      this.onTap});
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
            checkIsFollowed.refetch();
          }
        },
      ),
    );
    return ListTile(
      onTap: onTap,
      splashColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      leading: Stack(
        children: [
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: BoxDecoration(
              color: AppColors.primaryYellow,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  user.displayPic!.profile == ''
                      ? profilePlaceHolder
                      : user.displayPic!.profile!,
                ),
              ),
            ),
          ),
          OnlineIndicator(id: user.id!),
        ],
      ),
      title: Text(
        user.name == '' ? 'Unknown' : user.name!.capitalize!,
        overflow: TextOverflow.ellipsis,
        style: context.theme.textTheme.labelSmall,
      ),
      subtitle: Row(
        children: [
          const Icon(
            FlutterRemix.map_pin_2_fill,
            size: 12,
          ),
          const SizedBox(width: 8),
          Text(
            user.location!.address == '' ? 'Unknown' : user.location!.address!,
            style:
                context.theme.textTheme.labelSmall!.copyWith(fontSize: 10.sp),
          ),
        ],
      ),
      trailing: user.id != currentUser.value.id && showFollowButton
          ? InkWell(
              onTap: checkIsFollowed.result.isLoading
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
                  color: checkIsFollowed.result.data?['isFollowed'] == null
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
            )
          : const SizedBox.shrink(),
    );
  }
}
