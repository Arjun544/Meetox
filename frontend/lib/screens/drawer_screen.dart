
// import 'package:frontend/core/imports/core_imports.dart';
// import 'package:frontend/core/imports/packages_imports.dart';

// class DrawerScreen extends GetView<RootController> {
//   const DrawerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(RootController());

//     return ZoomDrawer(
//       controller: controller.zoomDrawerController,
//       style: DrawerStyle.defaultStyle,
//       menuScreen: const CustomDrawer(),
//       mainScreen: const RootScreen(),
//       borderRadius: 24.0,
//       showShadow: true,
//       angle: 0.0,
//       mainScreenScale: 0.2,
//       slideWidth: Get.width * 0.8,
//       mainScreenTapClose: true,
//       drawerShadowsBackgroundColor:
//           context.theme.bottomSheetTheme.backgroundColor!,
//       menuBackgroundColor: AppColors.customDarkGreen,
//     );
//   }
// }

// class RootScreen extends GetView<RootController> {
//   const RootScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomBottomNavigationBar(
//       items: [
//         NavItem(
//           tab: controller.items[0],
//           icon: FlutterRemix.bug_2_fill,
//           title: 'Bugs',
//           navigatorkey: controller.bugsNavigatorKey,
//         ),
//         NavItem(
//           tab: controller.items[1],
//           icon: FlutterRemix.mic_2_fill,
//           title: 'Spaces',
//           navigatorkey: controller.spacesNavigatorKey,
//         ),
//         NavItem(
//           tab: controller.items[2],
//           icon: FlutterRemix.message_3_fill,
//           title: 'Conversations',
//           navigatorkey: controller.conversationsNavigatorKey,
//         ),
//         NavItem(
//           tab: controller.items[3],
//           icon: FlutterRemix.notification_4_fill,
//           title: 'Notifications',
//           navigatorkey: controller.notificationsNavigatorKey,
//         ),
//       ],
//     );
//   }
// }




import 'package:frontend/core/imports/core_imports.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}