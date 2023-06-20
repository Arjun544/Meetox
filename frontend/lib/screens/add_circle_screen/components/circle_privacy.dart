import 'package:flutter/cupertino.dart';
import 'package:frontend/controllers/add_circle_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';

class CirclePrivacy extends GetView<AddCircleController> {
  const CirclePrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Private',
                style: context.theme.textTheme.labelLarge,
              ),
              Transform.scale(
                scale: 0.7,
                child: Obx(
                  () => CupertinoSwitch(
                    value: controller.isPrivate.value,
                    trackColor: Colors.black,
                    activeColor: AppColors.primaryYellow,
                    onChanged: (val) => controller.isPrivate.value = val,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.sp),
          Center(
            child: Container(
              width: Get.width * 0.5,
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                color: context.theme.indicatorColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(FlutterRemix.information_fill),
                  Obx(
                    () => Text(
                      controller.isPrivate.value
                          ? 'Only you can invite'
                          : 'Anyone can join',
                      style: context.theme.textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Limit',
                style: context.theme.textTheme.labelLarge,
              ),
              Obx(
                () => Text(
                  '${controller.limit.value.toStringAsFixed(0)} People',
                  style: context.theme.textTheme.labelSmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.sp),
          SizedBox(
            width: Get.width,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 5,
                inactiveTrackColor: context.theme.indicatorColor,
              ),
              child: Obx(
                () => Slider(
                  value: controller.limit.value,
                  min: 5,
                  max: 100,
                  thumbColor: context.theme.iconTheme.color,
                  inactiveColor: context.theme.indicatorColor,
                  activeColor: AppColors.primaryYellow,
                  onChanged: (val) => controller.limit.value = val,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.sp),
          Center(
            child: Container(
              width: Get.width * 0.7,
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                color: context.theme.indicatorColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(FlutterRemix.information_fill),
                  Text(
                    "Limit can't be change later",
                    style: context.theme.textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
