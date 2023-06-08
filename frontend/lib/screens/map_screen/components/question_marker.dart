import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/question_model.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

import 'question_details_sheet.dart';

class QuestionMarker extends HookWidget {
  const QuestionMarker({
    required this.question,
    required this.tappedQuestion,
    super.key,
  });
  final Question question;
  final Rx<Question> tappedQuestion;

  @override
  Widget build(BuildContext context) {
    final MapScreenController controller = Get.find();

    return AnimatedScale(
      scale: tappedQuestion.value.id != null ? 1.7 : 1,
      duration: const Duration(milliseconds: 400),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              tappedQuestion.value = question;
              controller.isFiltersVisible.value = false;
              showCustomSheet(
                context: context,
                hasBlur: false,
                enableDrag: false,
                child: QuestionDetailsSheet(
                  question,
                  tappedQuestion,
                ),
              );
            },
            child: Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                color: AppColors.customGrey,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 3,
                  color: Colors.green,
                ),
              ),
              child: const Icon(FlutterRemix.question_mark),
            ),
          ),
          Positioned(
            bottom: -15,
            child: Icon(
              FlutterRemix.arrow_down_s_fill,
              size: 25.sp,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
