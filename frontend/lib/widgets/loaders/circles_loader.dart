import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:shimmer/shimmer.dart';

class CirclesLoader extends StatelessWidget {
  const CirclesLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode
          ? Colors.grey.withOpacity(0.2)
          : AppColors.customGrey,
      highlightColor:
          context.isDarkMode ? AppColors.customBlack : Colors.grey[300]!,
      direction: ShimmerDirection.ttb,
      child: Column(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  height: 60.sp,
                  width: 50.sp,
                  decoration: BoxDecoration(
                    color: AppColors.primaryYellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(width: 30.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 16,
                      width: 100.sp,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Container(
                      height: 12,
                      width: 50.sp,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.sp),
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  height: 60.sp,
                  width: 50.sp,
                  decoration: BoxDecoration(
                    color: AppColors.primaryYellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(width: 30.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 16,
                      width: 100.sp,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Container(
                      height: 12,
                      width: 50.sp,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.sp),
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  height: 60.sp,
                  width: 50.sp,
                  decoration: BoxDecoration(
                    color: AppColors.primaryYellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(width: 30.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 16,
                      width: 100.sp,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Container(
                      height: 12,
                      width: 50.sp,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.sp),
        ],
      ),
    );
  }
}
