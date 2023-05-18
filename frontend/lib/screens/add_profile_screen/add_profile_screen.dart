import 'package:frontend/controllers/add_profile_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/user/mutations.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/add_profile_screen/components/step_one.dart';
import 'package:frontend/screens/add_profile_screen/components/step_three.dart';
import 'package:frontend/screens/add_profile_screen/components/step_two.dart';
import 'package:frontend/screens/root_screen.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/loaders/botton_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddProfileScreen extends GetView<AddProfileController> {
  const AddProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddProfileController());

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => controller.currentStep.value = value + 1,
        children: const [
          StepOne(),
          StepTwo(),
          StepThree(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SlideInUp(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Mutation(
            options: MutationOptions(
              document: gql(addProfile),
              fetchPolicy: FetchPolicy.networkOnly,
              update: (cache, result) => cache,
              onCompleted: (Map<String, dynamic>? resultData) async {
                logSuccess(resultData.toString());

                final user = User.fromJson(
                  resultData!['addProfile'] as Map<String, dynamic>,
                );

                currentUser.value = user;
                // ignore: invalid_use_of_protected_member
                currentUser.refresh();

                await Get.offAll(() => const DrawerScreen());
              },
              onError: (error) => logError('Unable to add profile'),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.currentStep.value > 1)
                            GestureDetector(
                              onTap: () async =>
                                  controller.pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : AppColors.customBlack,
                                  borderRadius: BorderRadius.circular(12),
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
                          else
                            const SizedBox.shrink(),
                          SizedBox(width: 50.sp),
                          CustomButton(
                            width: Get.width * 0.4,
                            text: controller.currentStep.value == 3
                                ? 'Submit'
                                : 'Next',
                            color: AppColors.primaryYellow,
                            onPressed: () async {
                              if (controller.currentStep.value == 1) {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  FocusScope.of(context).unfocus();
                                  await controller.pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              } else if (controller.currentStep.value == 3) {
                                await controller.handleSubmit(runMutation);
                                if (result.hasException) {
                                  showToast('Unable to add profile');
                                }
                              } else {
                                FocusScope.of(context).unfocus();
                                await controller.pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
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
