// ignore_for_file: invalid_use_of_protected_member

import 'package:frontend/controllers/add_circle_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/user_initials.dart';

class CircleMembers extends GetView<AddCircleController> {
  const CircleMembers({super.key});

  @override
  Widget build(BuildContext context) {
    // final followersQuery = usePaginatedInfiniteQuery<FollowerModel,
    //     Map<String, dynamic>, int, UserModel>(
    //   FollowersQueries.followersQuery,
    //   externalData: {},
    //   firstPageKey: 1,
    //   pagingController: addCircleController.followersPagingController,
    //   onData: (data, pagingController, pageKey) {
    //     final items = data.followers!.toList();

    //     if (!data.hasNextPage! && data.nextPage == data.page) {
    //       pagingController.appendLastPage(items);
    //     } else if (pagingController.nextPageKey != data.nextPage) {
    //       pagingController.appendPage(items, data.nextPage);
    //     }
    //   },
    // );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.sp),
          SlideInLeft(
            delay: const Duration(milliseconds: 500),
            from: 300,
            child: Row(
              children: [
                Text(
                  'Add members ',
                  style: context.theme.textTheme.titleLarge,
                ),
                Obx(
                  () => controller.selectedMembers.isNotEmpty
                      ? Text(
                          ' ${controller.selectedMembers.value.length} / ${controller.limit.value.toInt()} ',
                          style: context.theme.textTheme.labelSmall,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.sp),
          Obx(
            () => controller.selectedMembers.value.isEmpty
                ? Center(
                    child: Text(
                      'No members selected',
                      style: context.theme.textTheme.labelSmall,
                    ),
                  )
                : SizedBox(
                    height: Get.height * 0.1,
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: controller.selectedMembers.value.length,
                      padding: EdgeInsets.only(bottom: 10.sp),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              if (controller.selectedMembers.value[index]
                                      .displayPic ==
                                  null)
                                UserInititals(
                                  name: controller
                                      .selectedMembers.value[index].name!,
                                )
                              else
                                CircleAvatar(
                                  maxRadius: 25.sp,
                                  foregroundImage: CachedNetworkImageProvider(
                                    controller.selectedMembers.value[index]
                                        .displayPic!.profile!,
                                  ),
                                ),
                              InkWell(
                                onTap: () {
                                  controller.selectedMembers.value.remove(
                                    controller.selectedMembers.value[index],
                                  );
                                  controller.selectedMembers.refresh();
                                },
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: AppColors.customGrey,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Icon(
                                      FlutterRemix.close_fill,
                                      size: 14.sp,
                                      color: AppColors.customBlack,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ),
          SizedBox(height: 10.sp),
          SlideInLeft(
            delay: const Duration(milliseconds: 500),
            from: 300,
            child: Text(
              'Followers',
              style: context.theme.textTheme.labelLarge,
            ),
          ),
          // Expanded(
          //   child: RefreshIndicator(
          //     backgroundColor: AppColors.primaryYellow,
          //     color: AppColors.primaryYellow,
          //     onRefresh: () async => followersQuery.pagingController.refresh(),
          //     child: PagedListView(
          //       pagingController: followersQuery.pagingController,
          //       padding: EdgeInsets.symmetric(vertical: 15.sp),
          //       builderDelegate: PagedChildBuilderDelegate<UserModel>(
          //         animateTransitions: true,
          //         transitionDuration: const Duration(milliseconds: 500),
          //         firstPageProgressIndicatorBuilder: (_) => FollowersLoader(
          //           hasCheckBox: true,
          //         ),
          //         newPageProgressIndicatorBuilder: (_) => FollowersLoader(
          //           hasCheckBox: true,
          //         ),
          //         firstPageErrorIndicatorBuilder: (_) => Center(
          //           child: CustomErrorWidget(
          //             image: AssetsManager.angryState,
          //             text: 'Failed to fetch followers',
          //             onPressed: () =>
          //                 followersQuery.pagingController.refresh(),
          //           ),
          //         ),
          //         newPageErrorIndicatorBuilder: (_) => Center(
          //           child: CustomErrorWidget(
          //             image: AssetsManager.angryState,
          //             text: 'Failed to fetch followers',
          //             onPressed: () =>
          //                 followersQuery.pagingController.refresh(),
          //           ),
          //         ),
          //         noItemsFoundIndicatorBuilder: (_) => CustomErrorWidget(
          //           image: AssetsManager.sadState,
          //           text: 'No followers',
          //           onPressed: () => followersQuery.pagingController.refresh(),
          //         ),
          //         itemBuilder: (context, item, index) {
          //           return FollowerTile(
          //             follower: item,
          //             list: addCircleController.selectedMembers,
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
