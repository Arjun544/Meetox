import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

import 'user_details_sheet.dart';

class FollowerMarker extends HookWidget {
  const FollowerMarker({
    required this.follower,
    required this.tappedFollower,
    super.key,
  });
  final User follower;
  final Rx<User> tappedFollower;

  @override
  Widget build(BuildContext context) {
    final MapScreenController controller = Get.find();

    return AnimatedScale(
      scale: tappedFollower.value.id != null ? 1.7 : 1,
      duration: const Duration(milliseconds: 400),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              tappedFollower.value = follower;
              controller.isFiltersVisible.value = false;
              showCustomSheet(
                context: context,
                hasBlur: false,
                enableDrag: false,
                child: UserDetailsSheet(
                  follower,
                  tappedFollower,
                ),
              );
            },
            child: Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                color: AppColors.customGrey,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 3,
                  color: AppColors.primaryYellow,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    follower.displayPic!.profile!.isEmpty
                        ? profilePlaceHolder
                        : follower.displayPic!.profile!,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -15,
            child: Icon(
              FlutterRemix.arrow_down_s_fill,
              size: 25.sp,
              color: AppColors.primaryYellow,
            ),
          ),
        ],
      ),
    );
  }
}
