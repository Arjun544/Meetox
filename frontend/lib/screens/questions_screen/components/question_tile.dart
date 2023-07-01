import 'package:flutter/cupertino.dart';
import 'package:frontend/controllers/questions_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/question/mutation.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/models/question_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class QuestionTile extends StatelessWidget {
  const QuestionTile({
    required this.question,
    required this.onTap,
     this.questionsController,
    super.key,
    this.isShowingOnMap = false,
  });
  final Question question;
  final bool isShowingOnMap;
  final QuestionsController? questionsController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60.sp,
      margin: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(FlutterRemix.question_mark),
          ),
        ),
        title: Text(
          question.question!.capitalizeFirst!,
          style: context.theme.textTheme.labelMedium,
        ),
        subtitle: Text(
          question.expiry!.isAfter(DateTime.now())
              ? 'Expires In: ${timeago.format(
                  question.expiry!,
                  allowFromNow: true,
                )}'
              : 'Expired',
          style: question.expiry!.isAfter(DateTime.now())
              ? context.theme.textTheme.labelSmall
              : context.theme.textTheme.labelSmall!
                  .copyWith(color: Colors.redAccent),
        ),
        trailing: isShowingOnMap
            ? const SizedBox.shrink()
            : InkWell(
                onTap: () => showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: context.theme.textTheme.labelMedium,
                      ),
                    ),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () {},
                        child: Text(
                          'View profile',
                          style: context.theme.textTheme.labelMedium,
                        ),
                      ),
                      Mutation(
                        options: MutationOptions(
                          document: gql(deleteQuestion),
                          fetchPolicy: FetchPolicy.networkOnly,
                          onCompleted: (Map<String, dynamic>? resultData) =>
                              questionsController!.onDeleteCompleted(
                            resultData,
                            context,
                          ),
                          onError: (error) =>
                              showToast('Failed to delete question'),
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
                                    "id": question.id,
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
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Icon(
                    FlutterRemix.more_2_fill,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ),
      ),
    );
  }
}
