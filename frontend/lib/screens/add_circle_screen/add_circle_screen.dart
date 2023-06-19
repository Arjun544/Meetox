import 'package:frontend/controllers/add_circle_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/circle/mutations.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/screens/add_circle_screen/components/circle_avatar.dart';
import 'package:frontend/screens/add_circle_screen/components/circle_details.dart';
import 'package:frontend/screens/add_circle_screen/components/circle_members.dart';
import 'package:frontend/screens/add_circle_screen/components/circle_privacy.dart';
import 'package:frontend/widgets/close_button.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/loaders/botton_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddCircleScreen extends GetView<AddCircleController> {
  const AddCircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddCircleController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50.sp),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller.pageController, // PageController
                    count: 4,
                    effect: ExpandingDotsEffect(
                      dotHeight: 6.sp,
                      dotWidth: 6.sp,
                      activeDotColor: AppColors.primaryYellow,
                      dotColor: AppColors.customGrey,
                    ), // your preferred effect
                    onDotClicked: (index) {},
                  ),
                  CustomCloseButton(
                    onTap: () {
                      // Set data back to original
                      controller.currentStep.value = 0;
                      controller.nameController.clear();
                      controller.descController.clear();
                      controller.isPrivate.value = false;
                      controller.limit.value = 50.0;
                      controller.selectedAvatar.value = 0;
                      controller.capturedImage.value = XFile('');
                      controller.selectedImage.value =
                          const FilePickerResult([]);
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
                onPageChanged: (value) =>
                    controller.currentStep.value = value,
                children: const [
                  CircleDetails(),
                  CirclePrivacy(),
                  CircleAvatarDetails(),
                  CircleMembers(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SlideInUp(
        child: FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {},
          label: Mutation(
            options: MutationOptions(
              document: gql(addCircle),
              fetchPolicy: FetchPolicy.networkOnly,
              onCompleted: (Map<String, dynamic>? resultData) =>
                  controller.onComplete(resultData),
              onError: (error) => showToast('Failed to create circle'),
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
                          if (controller.currentStep.value > 0)
                            GestureDetector(
                              onTap: () async =>
                                  controller.pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                  color: context.theme.cardColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  FlutterRemix.arrow_left_s_line,
                                  color: Colors.white,
                                  size: 30.sp,
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          SizedBox(width: 50.sp),
                          Obx(
                            () => CustomButton(
                              width: Get.width * 0.4,
                              text: controller.currentStep.value == 3
                                  ? 'Submit'
                                  : 'Next',
                              color: AppColors.primaryYellow,
                              onPressed: () async {
                                if (controller.currentStep.value == 0) {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    FocusScope.of(context).unfocus();
                                    await controller.pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                } else if (controller.currentStep.value ==
                                    2) {
                                  await controller.pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                } else if (controller.currentStep.value ==
                                        3 &&
                                    controller.selectedMembers.length >
                                        controller.limit.value.toInt()) {
                                  showToast(
                                    'Your members limit is ${controller.limit.value.toInt()}',
                                  );
                                } else if (controller.currentStep.value ==
                                    3) {
                                  await controller.handleAddCircle(
                                      context, runMutation, result);
                                } else {
                                  FocusScope.of(context).unfocus();
                                  await controller.pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 50.sp),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
