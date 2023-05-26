import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:shimmer/shimmer.dart';

class FollowersLoader extends StatelessWidget {
  const FollowersLoader({required this.hasCheckBox, super.key});
  final bool hasCheckBox;
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
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          children: [
            Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    height: 40.sp,
                    width: 40.sp,
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(width: 20.sp),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 12,
                          width: 100.sp,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryYellow,
                          ),
                        ),
                        if (hasCheckBox)
                          Container(
                            height: 24.sp,
                            width: 20.sp,
                            decoration: BoxDecoration(
                              color: AppColors.primaryYellow,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.sp),
            Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    height: 40.sp,
                    width: 40.sp,
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(width: 20.sp),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 12,
                          width: 100.sp,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryYellow,
                          ),
                        ),
                        if (hasCheckBox)
                          Container(
                            height: 24.sp,
                            width: 20.sp,
                            decoration: BoxDecoration(
                              color: AppColors.primaryYellow,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.sp),
            Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    height: 40.sp,
                    width: 40.sp,
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(width: 20.sp),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 12,
                          width: 100.sp,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryYellow,
                          ),
                        ),
                        if (hasCheckBox)
                          Container(
                            height: 24.sp,
                            width: 20.sp,
                            decoration: BoxDecoration(
                              color: AppColors.primaryYellow,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.sp),
          ],
        ),
      ),
    );
  }
}
