import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:shimmer/shimmer.dart';

class SocialsLoaders extends StatelessWidget {
  const SocialsLoaders({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode
          ? Colors.grey.withOpacity(0.2)
          : AppColors.customGrey,
      highlightColor:
          context.isDarkMode ? AppColors.customBlack : Colors.grey[300]!,
      direction: ShimmerDirection.ttb,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(18.h),
            margin: EdgeInsets.only(right: 14.h),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            padding: EdgeInsets.all(18.h),
            margin: EdgeInsets.only(right: 14.h),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            padding: EdgeInsets.all(18.h),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
