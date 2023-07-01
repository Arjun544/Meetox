import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/answer_model.dart';
import 'package:frontend/models/question_model.dart';
import 'package:frontend/widgets/custom_error_widget.dart';
import 'package:frontend/widgets/loaders/followers_loader.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controllers/answers_controller.dart';
import 'components/answer_tile.dart';
import 'components/question_details.dart';

class AnswersScreen extends GetView<AnswersController> {
  final Question question;

  const AnswersScreen({super.key, required this.question});
  @override
  Widget build(BuildContext context) {
    Get.put(AnswersController(question.id!));
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            QuestionDetails(question: question),
          ];
        },
        body: RefreshIndicator(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          color: AppColors.primaryYellow,
          onRefresh: () async => controller.answersPagingController.refresh(),
          child: Padding(
            padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Answers',
                      style: context.theme.textTheme.labelLarge,
                    ),
                    const SizedBox(width: 10),
                    const Icon(IconsaxBold.messages_1)
                  ],
                ),
                SizedBox(height: 15.h),
                Expanded(
                  child: PagedListView(
                    pagingController: controller.answersPagingController,
                    padding: EdgeInsets.zero,
                    builderDelegate: PagedChildBuilderDelegate<Answer>(
                      animateTransitions: true,
                      transitionDuration: const Duration(milliseconds: 500),
                      firstPageProgressIndicatorBuilder: (_) =>
                          const FollowersLoader(hasCheckBox: false),
                      newPageProgressIndicatorBuilder: (_) =>
                          const FollowersLoader(hasCheckBox: false),
                      firstPageErrorIndicatorBuilder: (_) => Center(
                        child: CustomErrorWidget(
                          image: AssetsManager.angryState,
                          text: 'Failed to fetch answers',
                          onPressed: controller.answersPagingController.refresh,
                        ),
                      ),
                      newPageErrorIndicatorBuilder: (_) => Center(
                        child: CustomErrorWidget(
                          image: AssetsManager.angryState,
                          text: 'Failed to fetch answers',
                          onPressed: controller.answersPagingController.refresh,
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (_) => CustomErrorWidget(
                        image: AssetsManager.sadState,
                        text: 'No answers found',
                        isWarining: true,
                        onPressed: () {},
                      ),
                      itemBuilder: (context, item, index) => AnswerTile(
                        answer: item,
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
