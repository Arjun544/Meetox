import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/models/question_model.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

import 'add_answer_sheet.dart';

class QuestionDetails extends StatelessWidget {
  final Question question;

  const QuestionDetails({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(20.h),
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
                    child: Text(
                      question.question!.capitalizeFirst!,
                      style: context.theme.textTheme.labelMedium,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        width: Get.width * 0.3,
                        height: 32.h,
                        text: 'Reply',
                        color: context.theme.cardColor,
                        onPressed: () => showCustomSheet(
                          context: context,
                          child: AddAnswerSheet(
                            id: question.id!,
                            name: question.admin!.name!,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(
                                text: question.question!.capitalizeFirst!),
                          );
                          showToast('Question copied');
                        },
                        child: const Icon(
                          IconsaxBold.copy,
                          color: Colors.blueGrey,
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
