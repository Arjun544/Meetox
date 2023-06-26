import 'package:frontend/controllers/members_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/models/user_model.dart';
import 'package:frontend/widgets/custom_error_widget.dart';
import 'package:frontend/widgets/custom_field.dart';
import 'package:frontend/widgets/loaders/followers_loader.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'followers_screen/components/follower_tile.dart';

class MembersScreen extends GetView<MembersController> {
  final circle_model.Circle circle;

  const MembersScreen(this.circle, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MembersController(circle.id!));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          circle.name!.capitalizeFirst!,
          style: context.theme.textTheme.labelMedium,
        ),
        leading: InkWell(
          onTap: Get.back,
          child: Icon(FlutterRemix.arrow_left_s_line, size: 25.sp),
        ),
        iconTheme: context.theme.appBarTheme.iconTheme,
      ),
      body: RefreshIndicator(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        color: AppColors.primaryYellow,
        onRefresh: () async => controller.membersPagingController.refresh(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              SizedBox(
                height: 40.h,
                child: CustomField(
                  hintText: 'Search members',
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                  isPasswordVisible: true.obs,
                  hasFocus: false.obs,
                  autoFocus: false,
                  isSearchField: true,
                  keyboardType: TextInputType.text,
                  prefixIcon: FlutterRemix.search_2_fill,
                  onChanged: (value) => controller.membersSearchQuery(value),
                ),
              ),
              SizedBox(height: 15.sp),
              Expanded(
                child: PagedListView.separated(
                  pagingController: controller.membersPagingController,
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
                        text: 'Failed to fetch members',
                        onPressed: controller.membersPagingController.refresh,
                      ),
                    ),
                    newPageErrorIndicatorBuilder: (_) => Center(
                      child: CustomErrorWidget(
                        image: AssetsManager.angryState,
                        text: 'Failed to fetch members',
                        onPressed: controller.membersPagingController.refresh,
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
