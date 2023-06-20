import 'package:frontend/controllers/add_question_controller.dart';
import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_area_field.dart';
import 'package:frontend/widgets/mini_map.dart';

class AskQuestion extends GetView<AddQuestionController> {
  const AskQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    final RootController rootController = Get.find();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.sp,
        ),
        child: Column(
          children: [
            SizedBox(height: 30.sp),
            SlideInLeft(
              delay: const Duration(milliseconds: 500),
              from: 300,
              child: Text(
                'Have something to get a quick response within 24 hours?',
                style: context.theme.textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 30.sp),
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAreaField(
                    hintText: 'Ask a question',
                    text: controller.questionText,
                    controller: controller.questionController,
                    focusNode: controller.questionFocusNode,
                    hasFocus: controller.hasQuestionFocus,
                    formats: [
                      LengthLimitingTextInputFormatter(500),
                    ],
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Question is required';
                      }
                      if (val.length < 2) {
                        return 'Enter at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Obx(
                        () => Text(
                          '${controller.questionText.value.length} / 500',
                          style: context.theme.textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Center(
                    child: Container(
                      width: Get.width * 0.7,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.sp, vertical: 10.sp),
                      decoration: BoxDecoration(
                        color: context.theme.indicatorColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(FlutterRemix.information_fill),
                          Text(
                            'Your question will be visible\nfor next 24 hours.',
                            style: context.theme.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.sp),
                  Text(
                    'Location',
                    style: context.theme.textTheme.labelSmall,
                  ),
                  SizedBox(height: 15.sp),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 150.sp,
                      width: Get.width,
                      child: MiniMap(
                        latitude: rootController.currentPosition.value.latitude,
                        longitude:
                            rootController.currentPosition.value.longitude,
                      ),
                    ),
                  ),
                  SizedBox(height: 80.sp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
