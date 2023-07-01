import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/circle/mutations.dart';
import 'package:frontend/graphql/circle/queries.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../members_screen.dart';

class CircleDetails extends HookWidget {
  final circle_model.Circle circle;
  final ValueNotifier<int> members;

  const CircleDetails(this.circle, this.members, {super.key});

  @override
  Widget build(BuildContext context) {
    final checkIsMember = useQuery(
      QueryOptions(
        document: gql(isMember),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "id": circle.id,
        },
        onError: (data) => logError(data.toString()),
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

    return SliverAppBar(
      elevation: 0.1,
      expandedHeight: Get.height * 0.3,
      pinned: true,
      title: Text(
        circle.name!.capitalizeFirst!,
        style: context.theme.textTheme.labelMedium,
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
                          circle.image!.image!,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MembersScreen(circle));
                    },
                    child: Column(
                      children: [
                        Text(
                          members.value.toString(),
                          style: context.theme.textTheme.labelMedium,
                        ),
                        Text(
                          'Members',
                          style: context.theme.textTheme.labelSmall!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.to(() => FollowersScreen(circle, true));
                    },
                    child: Column(
                      children: [
                        Text(
                          circle.limit.toString(),
                          style: context.theme.textTheme.labelMedium,
                        ),
                        Text(
                          'Limit',
                          style: context.theme.textTheme.labelSmall!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (circle.isPrivate == false) ...[
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (checkIsMember.result.data!['isMember']) {
                          removeMember.runMutation({
                            "id": circle.id,
                          });
                        } else {
                          addNewMember.runMutation({
                            "id": circle.id,
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
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                checkIsMember.result.data?['isMember'] ?? false
                                    ? FlutterRemix.user_unfollow_fill
                                    : FlutterRemix.user_add_fill,
                                size: 16.sp,
                                color: context.theme.iconTheme.color,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                checkIsMember.result.data?['isMember'] ?? false
                                    ? 'Leave'
                                    : 'Join',
                                style: context.theme.textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
