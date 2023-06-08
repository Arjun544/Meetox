import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

import 'user_details_sheet.dart';

class UserMarker extends HookWidget {
  const UserMarker({
    required this.user,
    required this.tappedUser,
    super.key,
  });
  final User user;
  final Rx<User> tappedUser;

  @override
  Widget build(BuildContext context) {
    final MapScreenController controller = Get.find();

    return AnimatedScale(
      scale: tappedUser.value.id != null ? 1.7 : 1,
      duration: const Duration(milliseconds: 400),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              tappedUser.value = user;
              controller.isFiltersVisible.value = false;
              showCustomSheet(
                context: context,
                hasBlur: false,
                enableDrag: false,
                child: UserDetailsSheet(
                  user,
                  tappedUser,
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
                  color: Colors.orange,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    user.displayPic!.profile!.isEmpty
                        ? profilePlaceHolder
                        : user.displayPic!.profile!,
                  ),
                ),
              ),
            ),
            // : Container(
            //     width: 40.sp,
            //     height: 40.sp,
            //     decoration: BoxDecoration(
            //       color: isQuestionMarker
            //           ? Colors.green
            //           : AppColors.customGrey,
            //       borderRadius: BorderRadius.circular(15),
            //       border: Border.all(
            //         width: 3,
            //         color: color,
            //       ),
            //     ),
            //     child: Icon(
            //       FlutterRemix.question_fill,
            //       color: Colors.white,
            //       size: 35.sp,
            //     ),
            //   ),
          ),
          Positioned(
            bottom: -15,
            child: Icon(
              FlutterRemix.arrow_down_s_fill,
              size: 25.sp,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
