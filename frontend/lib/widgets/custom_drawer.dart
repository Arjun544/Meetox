import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/screens/circles_screen/circles_screen.dart';
import 'package:frontend/widgets/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      margin: EdgeInsets.only(top: 50.sp, right: 10.sp, left: 12.sp),
      color: AppColors.primaryYellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            currentUser.value.name == '' ? 'Unknown' : currentUser.value.name!,
            style: context.theme.textTheme.titleLarge,
          ),
          Text(
            'Menu',
            style: context.theme.textTheme.labelMedium!.copyWith(
              color: AppColors.customBlack,
            ),
          ),
          SizedBox(
            height: Get.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DrawerTile(
                  title: 'View profile',
                  icon: FlutterRemix.profile_fill,
                  onPressed: () {},
                ),
                DrawerTile(
                  icon: FlutterRemix.footprint_fill,
                  title: 'Cross paths',
                  onPressed: () {},
                ),
                DrawerTile(
                  icon: FlutterRemix.bubble_chart_fill,
                  title: 'Circles',
                  onPressed: () => Get.to(() => const CirclesScreen()),
                ),
                DrawerTile(
                  icon: FlutterRemix.question_fill,
                  title: 'Questions',
                  onPressed: () {},
                ),
                DrawerTile(
                  icon: FlutterRemix.shopping_bag_fill,
                  title: 'Jobs',
                  onPressed: () {},
                ),
                DrawerTile(
                  icon: FlutterRemix.logout_circle_fill,
                  title: 'Logout',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Others',
                style: context.theme.textTheme.labelMedium!.copyWith(
                  color: AppColors.customBlack,
                ),
              ),
              const SizedBox(height: 20),
              DrawerTile(
                icon: FlutterRemix.open_arm_fill,
                title: 'Invite on Meetox',
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              DrawerTile(
                icon: FlutterRemix.share_circle_fill,
                title: 'Share your profile',
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsManager.appLogo,
                height: 25.sp,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(width: 20),
              Text(
                'version 1.0.0',
                style: context.theme.textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
