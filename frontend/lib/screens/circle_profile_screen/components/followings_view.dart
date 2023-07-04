import 'package:frontend/controllers/circle_profile_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/widgets/custom_error_widget.dart';
import 'package:frontend/widgets/custom_field.dart';
import 'package:frontend/widgets/loaders/followers_loader.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'follower_tile.dart';

class FollowingView extends GetView<CircleProfileController> {
  final String id;
  final ValueNotifier<int> members;

  const FollowingView(this.id, this.members, {super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      color: AppColors.primaryYellow,
      onRefresh: () async => controller.followingPagingController.refresh(),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          SizedBox(
            height: 40.h,
            child: CustomField(
              hintText: 'Search following',
              controller: TextEditingController(),
              focusNode: FocusNode(),
              isPasswordVisible: true.obs,
              hasFocus: false.obs,
              autoFocus: false,
              isSearchField: true,
              keyboardType: TextInputType.text,
              prefixIcon: FlutterRemix.search_2_fill,
              onChanged: (value) => controller.followingSearchQuery(value),
            ),
          ),
          SizedBox(height: 15.sp),
          Expanded(
            child: PagedListView.separated(
              pagingController: controller.followingPagingController,
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
                    text: 'Failed to fetch following',
                    onPressed: controller.followingPagingController.refresh,
                  ),
                ),
                newPageErrorIndicatorBuilder: (_) => Center(
                  child: CustomErrorWidget(
                    image: AssetsManager.angryState,
                    text: 'Failed to fetch following',
                    onPressed: controller.followingPagingController.refresh,
                  ),
                ),
                noItemsFoundIndicatorBuilder: (_) => CustomErrorWidget(
                  image: AssetsManager.sadState,
                  text: 'No following found',
                  isWarining: true,
                  onPressed: () {},
                ),
                itemBuilder: (context, item, index) => FollowerTile(
                  user: item,
                  id: id,
                  members: members,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
