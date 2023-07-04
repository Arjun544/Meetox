import 'package:flutter/cupertino.dart';
import 'package:frontend/controllers/circles_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/circle/mutations.dart';
import 'package:frontend/graphql/circle/queries.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/screens/circle_profile_screen/components/add_member_sheet.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../members_screen.dart';

class CircleDetails extends HookWidget {
  final circle_model.Circle circle;
  final ValueNotifier<int> members;

  const CircleDetails(this.circle, this.members, {super.key});

  @override
  Widget build(BuildContext context) {
    final CirclesController circlesController = Get.find();
    final checkIsMember = useQuery(
      QueryOptions(
        document: gql(isMember),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "id": circle.id,
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

    return SliverAppBar(
      elevation: 0.1,
      expandedHeight: Get.height * 0.3,
      pinned: true,
      title: Text(
        circle.name!.capitalizeFirst!,
        style: context.theme.textTheme.labelMedium,
      ),
      actions: circle.admin == currentUser.value.id
          ? [
              IconButton(
                onPressed: () => showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: Text(
                      'Are you sure?',
                      style: context.theme.textTheme.labelMedium,
                    ),
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: context.theme.textTheme.labelMedium,
                      ),
                    ),
                    actions: [
                      Mutation(
                        options: MutationOptions(
                          document: gql(deleteCircle),
                          fetchPolicy: FetchPolicy.networkOnly,
                          onCompleted: (Map<String, dynamic>? resultData) {
                            circlesController.onDeleteCompleted(
                              resultData,
                              context,
                            );
                            Get.back();
                          },
                          onError: (error) =>
                              showToast('Failed to delete circle'),
                        ),
                        builder: (runMutation, result) {
                          return result!.isLoading
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.42,
                                      vertical: 8.h),
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: AppColors.primaryYellow,
                                    size: 25.sp,
                                  ),
                                )
                              : CupertinoActionSheetAction(
                                  isDestructiveAction: true,
                                  onPressed: () => runMutation({
                                    "id": circle.id,
                                  }),
                                  child: Text(
                                    'Delete',
                                    style: context.theme.textTheme.labelMedium!
                                        .copyWith(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
                icon: const Icon(
                  IconsaxBold.trash,
                  color: Colors.redAccent,
                ),
              ),
            ]
          : null,
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
                  Column(
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
                ],
              ),
              if (circle.admin == currentUser.value.id) ...[
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      width: Get.width * 0.15,
                      height: 35.h,
                      color: context.theme.indicatorColor,
                      icon: const Icon(
                        IconsaxBold.edit_2,
                      ),
                      onPressed: () {},
                    ),
                    CustomButton(
                      width: Get.width * 0.15,
                      height: 35.h,
                      color: context.theme.indicatorColor,
                      icon: const Icon(
                        IconsaxBold.user_add,
                      ),
                      onPressed: () => showCustomSheet(
                        context: context,
                        child: AddMemberSheet(
                          circle.id!,
                          members,
                          circle.limit!,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (circle.isPrivate == false &&
                  circle.admin != currentUser.value.id) ...[
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
                          if (members.value == circle.limit) {
                            showToast('Circle reached members limit');
                          } else {
                            addNewMember.runMutation({
                              "id": circle.id,
                            });
                          }
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
