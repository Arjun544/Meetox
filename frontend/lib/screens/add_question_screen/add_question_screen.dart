import 'package:frontend/controllers/add_question_controller.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/question/mutations.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/widgets/close_button.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/loaders/botton_loader.dart';
import 'package:frontend/widgets/unfocuser.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../core/imports/core_imports.dart';
import 'components/ask_question.dart';

class AddQuestionScreen extends GetView<AddQuestionController> {
  const AddQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddQuestionController());
    return UnFocuser(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 0,
                  ),
                  // SmoothPageIndicator(
                  //   controller: controller.pageController, // PageController
                  //   count: 1,
                  //   effect: ExpandingDotsEffect(
                  //     dotHeight: 6.sp,
                  //     dotWidth: 6.sp,
                  //     activeDotColor: AppColors.primaryYellow,
                  //     dotColor: AppColors.customGrey,
                  //   ), // your preferred effect
                  //   onDotClicked: (index) {},
                  // ),
                  CustomCloseButton(
                    onTap: () {
                      controller.currentStep.value = 0;
                      controller.questionController.clear();
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) => controller.currentStep.value = value,
                children: const [
                  AskQuestion(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SlideInUp(
          child: FloatingActionButton.extended(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {},
            label: Mutation(
                options: MutationOptions(
                  document: gql(addQuestion),
                  fetchPolicy: FetchPolicy.networkOnly,
                  onCompleted: (Map<String, dynamic>? resultData) =>
                      controller.onComplete(resultData),
                  onError: (error) => showToast('Failed to ask question'),
                ),
                builder: (runMutation, result) {
                  return result!.isLoading
                      ? ButtonLoader(
                          width: Get.width * 0.4,
                          color: AppColors.primaryYellow,
                          loaderColor: Colors.white,
                        )
                      : Obx(
                          () => Row(
                            children: [
                              controller.currentStep.value > 0
                                  ? GestureDetector(
                                      onTap: () async => await controller
                                          .pageController
                                          .previousPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(12.sp),
                                        decoration: BoxDecoration(
                                          color: context.isDarkMode
                                              ? Colors.white
                                              : AppColors.customBlack,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          FlutterRemix.arrow_left_s_line,
                                          color: context.isDarkMode
                                              ? AppColors.customBlack
                                              : Colors.white,
                                          size: 30.sp,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              SizedBox(width: 50.sp),
                              CustomButton(
                                width: Get.width * 0.4,
                                text: controller.currentStep.value == 0
                                    ? 'Submit'
                                    : 'Next',
                                color: AppColors.primaryYellow,
                                onPressed: () async {
                                  if (controller.currentStep.value == 0) {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      FocusScope.of(context).unfocus();
                                      controller.handleAddQuestion(
                                        context,
                                        runMutation,
                                        result,
                                      );
                                    }
                                  }
                                },
                              ),
                              SizedBox(width: 50.sp),
                            ],
                          ),
                        );
                }),
          ),
        ),
      ),
    );
  }
}
