import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/question/mutation.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/models/question_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QuestionDetails extends HookWidget {
  final Question question;
  final ValueNotifier<List<String>> likes;

  const QuestionDetails(
      {super.key, required this.question, required this.likes});

  @override
  Widget build(BuildContext context) {
    final likeQuestionMutaion = useMutation(
      MutationOptions(
        document: gql(toggleLikeQuestion),
        onCompleted: (data) {
          if (data != null && data['toggleLikeQuestion'] != null) {
            if (likes.value.contains(currentUser.value.id!)) {
              likes.value.remove(currentUser.value.id!);
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              likes.notifyListeners();
            } else {
              likes.value.add(currentUser.value.id!);
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              likes.notifyListeners();
            }
          }
        },
      ),
    );
    return SliverAppBar(
      elevation: 0.1,
      expandedHeight: Get.height * 0.4,
      pinned: true,
      title: Text(
        'Question',
        style: context.theme.textTheme.labelMedium,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: Get.height * 0.15),
              padding: EdgeInsets.fromLTRB(0, 20.h, 0, 10.h),
              constraints: BoxConstraints(
                minHeight: Get.height * 0.05,
                maxHeight: Get.height * 0.3,
              ),
              decoration: BoxDecoration(
                color: context.theme.indicatorColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 20),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.h, 20.h, 20.h, 10.h),
                      child: Text(
                        question.question!.capitalizeFirst!,
                        style: context.theme.textTheme.labelMedium,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: question.question!.capitalizeFirst!,
                            ),
                          );
                          showToast('Question copied');
                        },
                        child: const Icon(
                          IconsaxBold.copy,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: likeQuestionMutaion.result.isLoading
                            ? () {}
                            : () {
                                likeQuestionMutaion
                                    .runMutation({"id": question.id});
                              },
                        child: Row(
                          children: [
                            Icon(
                              IconsaxBold.like_1,
                              color: likes.value.contains(currentUser.value.id!)
                                  ? Colors.blue
                                  : Colors.blueGrey,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              likes.value.length.toString(),
                              style:
                                  context.theme.textTheme.labelSmall!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: Get.height * 0.07,
              child: Container(
                height: Get.height * 0.16,
                width: Get.width * 0.16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: context.theme.scaffoldBackgroundColor, width: 4),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      question.admin!.displayPic!.profile!,
                    ),
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
