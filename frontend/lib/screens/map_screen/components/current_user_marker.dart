import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/user_initials.dart';

class CurrentUserMarker extends StatelessWidget {

  const CurrentUserMarker({super.key, this.isMiniMap = false});
  final bool isMiniMap;

  @override
  Widget build(BuildContext context) {
    return Pulse(
      infinite: true,
      // ignore: avoid_bool_literals_in_conditional_expressions
      animate: isMiniMap ? false : true,
      child: InkWell(
        onTap: () {},
        // TODO:
        // onTap: () => Get.to(() => ProfileScreen()),
        child: Container(
          width: 70.sp,
          height: 70.sp,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isMiniMap
                ? Colors.transparent
                : AppColors.primaryYellow.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Dance(
            duration: const Duration(milliseconds: 2000),
            infinite: true,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Obx(
                  () => currentUser.value.displayPic == null
                      ? UserInititals(name: currentUser.value.name!)
                      : Container(
                          width: isMiniMap ? 40.sp : 50.sp,
                          height: isMiniMap ? 40.sp : 50.sp,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: AppColors.customGrey,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: isMiniMap ? 3 : 4,
                              color: AppColors.primaryYellow,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                currentUser.value.displayPic!.profile!,
                              ),
                            ),
                          ),
                        ),
                ),
                Positioned(
                  bottom: -18,
                  child: Icon(
                    FlutterRemix.arrow_down_s_fill,
                    size: 30.sp,
                    color: AppColors.primaryYellow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
