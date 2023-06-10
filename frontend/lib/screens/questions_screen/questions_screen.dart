import 'package:frontend/controllers/questions_cotroller.dart';
import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/question_model.dart';
import 'package:frontend/screens/root_screen.dart';
import 'package:frontend/widgets/custom_error_widget.dart';
import 'package:frontend/widgets/custom_field.dart';
import 'package:frontend/widgets/loaders/circles_loader.dart';
import 'package:frontend/widgets/unfocuser.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../add_question_screen/add_question_screen.dart';
import 'components/question_tile.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QuestionsController());
    final rootController = Get.find<RootController>();

    return UnFocuser(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Questions',
            style: context.theme.textTheme.labelMedium,
          ),
          leading: InkWell(
            onTap: Get.back,
            child: Icon(FlutterRemix.arrow_left_s_line, size: 25.sp),
          ),
          iconTheme: context.theme.appBarTheme.iconTheme,
          actions: [
            InkWell(
              onTap: () => Get.to(() => const AddQuestionScreen()),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.theme.dialogBackgroundColor,
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
          onRefresh: () async => controller.questiosPagingController.refresh(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                SizedBox(
                  height: 50.sp,
                  child: CustomField(
                    hintText: 'Search questions',
                    controller: TextEditingController(),
                    focusNode: FocusNode(),
                    isPasswordVisible: true.obs,
                    autoFocus: false,
                    hasFocus: false.obs,
                    keyboardType: TextInputType.text,
                    prefixIcon: FlutterRemix.search_2_fill,
                    onChanged: (value) {
                      controller.searchQuery(value);
                    },
                  ),
                ),
                SizedBox(height: 15.sp),
                Expanded(
                  child: PagedListView.separated(
                    pagingController: controller.questiosPagingController,
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1,
                      color: context.theme.canvasColor.withOpacity(0.1),
                    ),
                    builderDelegate: PagedChildBuilderDelegate<Question>(
                      animateTransitions: true,
                      transitionDuration: const Duration(milliseconds: 500),
                      firstPageProgressIndicatorBuilder: (_) =>
                          const CirclesLoader(),
                      newPageProgressIndicatorBuilder: (_) =>
                          const CirclesLoader(),
                      firstPageErrorIndicatorBuilder: (_) => Center(
                        child: CustomErrorWidget(
                          image: AssetsManager.angryState,
                          text: 'Failed to fetch questions',
                          onPressed:
                              controller.questiosPagingController.refresh,
                        ),
                      ),
                      newPageErrorIndicatorBuilder: (_) => Center(
                        child: CustomErrorWidget(
                          image: AssetsManager.angryState,
                          text: 'Failed to fetch questions',
                          onPressed:
                              controller.questiosPagingController.refresh,
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (_) => CustomErrorWidget(
                        image: AssetsManager.sadState,
                        text: 'No questions found',
                        btnText: 'Find nearby',
                        onPressed: () {
                          rootController.selectedTab.value = 0;
                          Get.to(() => const DrawerScreen());
                        },
                      ),
                      itemBuilder: (context, item, index) => QuestionTile(
                        question: item,
                        questionsController: controller,
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
