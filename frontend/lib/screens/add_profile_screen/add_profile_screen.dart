import 'package:frontend/controllers/add_profile_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/screens/add_profile_screen/components/step_one.dart';
import 'package:frontend/screens/add_profile_screen/components/step_three.dart';
import 'package:frontend/screens/add_profile_screen/components/step_two.dart';
import 'package:frontend/widgets/custom_button.dart';

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
          child: FloatingActionButton.extended(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {},
            label: Obx(
              () => controller.isLoading.value
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primaryYellow,
                      size: 35.sp,
                    )
                  : Row(
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
                              if (controller.formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                await controller.pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            } else if (controller.currentStep.value == 3) {
                              await controller.handleSubmit();
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
            ),
          ),
        ),
      ),
    );
  }
}
