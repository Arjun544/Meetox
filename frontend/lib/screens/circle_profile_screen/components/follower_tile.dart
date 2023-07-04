import 'package:frontend/graphql/circle/mutations.dart';
import 'package:frontend/graphql/circle/queries.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/user_profile_screen/user_profile_screen.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/online_indicator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';

class FollowerTile extends HookWidget {
  final String id;
  final User user;
  final ValueNotifier<int> members;

  const FollowerTile({
    super.key,
    required this.user,
    required this.id,
    required this.members,
  });
  @override
  Widget build(BuildContext context) {
    final checkIsMember = useQuery(
      QueryOptions(
        document: gql(isMember),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "id": id,
        },
      ),
    );
    final addNewMember = useMutation(
      MutationOptions(
        document: gql(addMember),
        onCompleted: (data) {
          if (data != null && data['addMember'] != null) {
            members.value += 1;
            checkIsMember.refetch();
          }
        },
      ),
    );
    final removeMember = useMutation(
      MutationOptions(
        document: gql(leaveMember),
        onCompleted: (data) {
          if (data != null && data['leaveMember'] != null) {
            members.value -= 1;
            checkIsMember.refetch();
          }
        },
      ),
    );

    return ListTile(
      onTap: () => Get.to(
        () => UserProfileScreen(
          user: user,
          followers: ValueNotifier(user.followers!),
        ),
      ),
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
      trailing: user.id != currentUser.value.id
          ? InkWell(
              onTap: checkIsMember.result.isLoading
                  ? () {}
                  : () async {
                      if (checkIsMember.result.data!['isMember']) {
                        removeMember.runMutation({
                          "id": id,
                        });
                      } else {
                        addNewMember.runMutation({
                          "id": id,
                        });
                      }
                    },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: checkIsMember.result.data?['isMember'] == null
                      ? AppColors.primaryYellow
                      : checkIsMember.result.data?['isMember']
                          ? Colors.redAccent
                          : AppColors.primaryYellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.sp,
                    vertical: 6.sp,
                  ),
                  child: checkIsMember.result.isLoading
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.customBlack,
                          size: 16.sp,
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              checkIsMember.result.data!['isMember']
                                  ? FlutterRemix.user_unfollow_fill
                                  : FlutterRemix.user_add_fill,
                              size: 16.sp,
                              color: context.theme.iconTheme.color,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              checkIsMember.result.data!['isMember']
                                  ? 'Remove'
                                  : 'Add',
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
