import 'package:frontend/controllers/add_profile_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/custom_field.dart';

class StepOne extends GetView<AddProfileController> {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalHorizentalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 75.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SlideInLeft(
                child: Text(
                  'About you',
                  style: context.theme.textTheme.titleLarge,
                ),
              ),
              SmoothPageIndicator(
                controller: controller.pageController, // PageController
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 6.sp,
                  dotWidth: 6.sp,
                  activeDotColor: AppColors.primaryYellow,
                  dotColor: AppColors.customGrey,
                ), // your preferred effect
                onDotClicked: (index) {},
              ),
            ],
          ),
          SizedBox(height: 15.sp),
          SlideInLeft(
            delay: const Duration(milliseconds: 500),
            from: 300,
            child: Text(
              'Let us know your good name',
              style: context.theme.textTheme.labelSmall,
            ),
          ),
          SizedBox(height: 50.sp),
          Form(
            key: controller.formKey,
            child: CustomField(
              hintText: 'Username',
              controller: controller.nameController,
              focusNode: controller.nameFocusNode,
              isPasswordVisible: true.obs,
              hasFocus: controller.hasNameFocus,
              keyboardType: TextInputType.name,
              formats: [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.allow(
                  RegExp('[a-z A-Z á-ú Á-Ú 0-9 @.]'),
                ),
              ],
              prefixIcon: FlutterRemix.user_4_fill,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Username is required';
                }
                if (val.length < 2) {
                  return 'Enter at least 2 characters';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
