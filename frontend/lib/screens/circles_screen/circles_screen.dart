import 'package:frontend/controllers/circles_controller.dart';
import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/screens/add_circle_screen/add_circle_screen.dart';
import 'package:frontend/screens/circles_screen/components/circle_tile.dart';
import 'package:frontend/screens/root_screen.dart';
import 'package:frontend/widgets/custom_error_widget.dart';
import 'package:frontend/widgets/custom_field.dart';
import 'package:frontend/widgets/loaders/circles_loader.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CirclesScreen extends GetView<CirclesController> {
  const CirclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CirclesController());
    final rootController = Get.find<RootController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Circles',
          style: context.theme.textTheme.labelMedium,
        ),
        leading: InkWell(
          onTap: Get.back,
          child: Icon(FlutterRemix.arrow_left_s_line, size: 25.sp),
        ),
        iconTheme: context.theme.appBarTheme.iconTheme,
        actions: [
          InkWell(
            onTap: () => Get.to(() => const AddCircleScreen()),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.theme.indicatorColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    FlutterRemix.add_fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        color: AppColors.primaryYellow,
        onRefresh: () async => controller.circlesPagingController.refresh(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              SizedBox(
                height: 40.h,
                child: CustomField(
                  hintText: 'Search circles',
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                  isPasswordVisible: true.obs,
                  hasFocus: false.obs,
                  autoFocus: false,
                  isSearchField: true,
                  keyboardType: TextInputType.text,
                  prefixIcon: FlutterRemix.search_2_fill,
                  onChanged: (value) => controller.searchQuery(value),
                ),
              ),
              SizedBox(height: 15.sp),
              Expanded(
                child: PagedListView.separated(
                  pagingController: controller.circlesPagingController,
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    color: context.theme.canvasColor.withOpacity(0.1),
                  ),
                  builderDelegate:
                      PagedChildBuilderDelegate<circle_model.Circle>(
                    animateTransitions: true,
                    transitionDuration: const Duration(milliseconds: 500),
                    firstPageProgressIndicatorBuilder: (_) =>
                        const CirclesLoader(),
                    newPageProgressIndicatorBuilder: (_) =>
                        const CirclesLoader(),
                    firstPageErrorIndicatorBuilder: (_) => Center(
                      child: CustomErrorWidget(
                        image: AssetsManager.angryState,
                        text: 'Failed to fetch circles',
                        onPressed: controller.circlesPagingController.refresh,
                      ),
                    ),
                    newPageErrorIndicatorBuilder: (_) => Center(
                      child: CustomErrorWidget(
                        image: AssetsManager.angryState,
                        text: 'Failed to fetch circles',
                        onPressed: controller.circlesPagingController.refresh,
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => CustomErrorWidget(
                      image: AssetsManager.sadState,
                      text: 'No circles found',
                      btnText: 'Find nearby',
                      onPressed: () {
                        rootController.selectedTab.value = 0;
                        Get.to(() => const DrawerScreen());
                      },
                    ),
                    itemBuilder: (context, item, index) => CircleTile(
                      circle: item,
                      circlesController: controller,
                      onTap: () {},
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
