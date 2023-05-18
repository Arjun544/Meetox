import 'package:flutter/cupertino.dart';
import 'package:frontend/controllers/add_profile_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/utils/constants.dart';

class StepThree extends GetView<AddProfileController> {
  const StepThree({super.key});

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
                  'Your Birth day',
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
              'We will make you feel special every year',
              style: context.theme.textTheme.labelSmall,
            ),
          ),
          SizedBox(height: 50.sp),
          SizedBox(
            height: Get.height * 0.6,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  pickerTextStyle: context.theme.textTheme.labelSmall,
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now()
                    .subtract(const Duration(days: 2922)), // 8 years
                maximumDate:
                    DateTime.now().subtract(const Duration(days: 2922)),
                minimumDate: DateTime.now()
                    .subtract(const Duration(days: 36525)), // 100 years
                dateOrder: DatePickerDateOrder.dmy,
                onDateTimeChanged: (date) => controller.birthDate.value = date,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
