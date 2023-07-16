import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:shimmer/shimmer.dart';

import '../../screens/chat_screen/components/chat_shape.dart';

// import '../../screens/chat_screen/components/chat_shape.dart';

class ChatLoader extends StatelessWidget {
  const ChatLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode
          ? Colors.grey.withOpacity(0.2)
          : AppColors.customGrey,
      highlightColor:
          context.isDarkMode ? AppColors.customBlack : Colors.grey[300]!,
      direction: ShimmerDirection.ttb,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.75,
                    ),
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Container(
                      height: 16,
                      width: 100.sp,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ),
                ),
                CustomPaint(
                  painter: CustomShape(context.theme.scaffoldBackgroundColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        // child: CustomPaint(
                        //   painter: CustomShape(
                        //       context.theme.scaffoldBackgroundColor),
                        // ),
                      ),
                      Flexible(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: Get.width * 0.75,
                          ),
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                          ),
                          child: Container(
                            height: 16,
                            width: 100.sp,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryYellow,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.75,
                    ),
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Container(
                      height: 16,
                      width: 100.sp,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ),
                ),
                // CustomPaint(
                //   painter: CustomShape(context.theme.scaffoldBackgroundColor),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.75,
                    ),
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Container(
                      height: 16,
                      width: 100.sp,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ),
                ),
                // CustomPaint(
                //   painter: CustomShape(context.theme.scaffoldBackgroundColor),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.75,
                    ),
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Container(
                      height: 16,
                      width: 100.sp,
                      decoration: const BoxDecoration(),
                    ),
                  ),
                ),
                // CustomPaint(
                //   painter: CustomShape(context.theme.scaffoldBackgroundColor),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        // child: CustomPaint(
                        //   painter: CustomShape(
                        //       context.theme.scaffoldBackgroundColor),
                        // ),
                      ),
                      Flexible(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: Get.width * 0.75,
                          ),
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                          ),
                          child: Container(
                            height: 16,
                            width: 100.sp,
                            decoration: const BoxDecoration(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
