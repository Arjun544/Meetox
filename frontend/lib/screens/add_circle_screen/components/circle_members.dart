// ignore_for_file: invalid_use_of_protected_member

import 'package:frontend/controllers/add_circle_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/followers_screen/components/follower_tile.dart';
import 'package:frontend/widgets/custom_error_widget.dart';
import 'package:frontend/widgets/custom_field.dart';
import 'package:frontend/widgets/loaders/followers_loader.dart';
import 'package:frontend/widgets/user_initials.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CircleMembers extends GetView<AddCircleController> {
  const CircleMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: RefreshIndicator(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        color: AppColors.primaryYellow,
        onRefresh: () async => controller.followersPagingController.refresh(),
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
            SizedBox(height: 30.h),
            // SlideInLeft(
            //   delay: const Duration(milliseconds: 500),
            //   from: 300,
            //   child: Text(
            //     'Followers',
            //     style: context.theme.textTheme.labelLarge,
            //   ),
            // ),
            SizedBox(
              height: 40.h,
              width: Get.width,
              child: CustomField(
                hintText: 'Search followers',
                controller: TextEditingController(),
                focusNode: FocusNode(),
                isPasswordVisible: true.obs,
                hasFocus: false.obs,
                autoFocus: false,
                isSearchField: true,
                keyboardType: TextInputType.text,
                prefixIcon: FlutterRemix.search_2_fill,
                onChanged: (value) => controller.followersSearchQuery(value),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: PagedListView.separated(
                padding: EdgeInsets.zero,
                pagingController: controller.followersPagingController,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  color: context.theme.canvasColor.withOpacity(0.1),
                ),
                builderDelegate: PagedChildBuilderDelegate<User>(
                  animateTransitions: true,
                  transitionDuration: const Duration(milliseconds: 500),
                  firstPageProgressIndicatorBuilder: (_) =>
                      const FollowersLoader(hasCheckBox: false),
                  newPageProgressIndicatorBuilder: (_) =>
                      const FollowersLoader(hasCheckBox: false),
                  firstPageErrorIndicatorBuilder: (_) => Center(
                    child: CustomErrorWidget(
                      image: AssetsManager.angryState,
                      text: 'Failed to fetch followers',
                      onPressed: controller.followersPagingController.refresh,
                    ),
                  ),
                  newPageErrorIndicatorBuilder: (_) => Center(
                    child: CustomErrorWidget(
                      image: AssetsManager.angryState,
                      text: 'Failed to fetch followers',
                      onPressed: controller.followersPagingController.refresh,
                    ),
                  ),
                  noItemsFoundIndicatorBuilder: (_) => CustomErrorWidget(
                    image: AssetsManager.sadState,
                    text: 'No followers found',
                    isWarining: true,
                    onPressed: () {},
                  ),
                  itemBuilder: (context, item, index) => FollowerTile(
                    user: item,
                    showFollowButton: false,
                    onTap: () {
                      if (controller.selectedMembers.contains(item)) {
                        controller.selectedMembers.remove(item);
                      } else {
                        controller.selectedMembers.add(item);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
