import 'dart:developer';

import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_drawer.dart';
import 'package:frontend/widgets/navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class DrawerScreen extends GetView<RootController> {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RootController());

    return ZoomDrawer(
      controller: controller.zoomDrawerController,
      menuScreen: const CustomDrawer(),
      mainScreen: const RootScreen(),
      borderRadius: 24,
      showShadow: true,
      angle: 0,
      mainScreenScale: 0.2,
      slideWidth: Get.width * 0.8,
      mainScreenTapClose: true,
      drawerShadowsBackgroundColor:
          context.theme.bottomSheetTheme.backgroundColor!,
      menuBackgroundColor: AppColors.primaryYellow,
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with WidgetsBindingObserver {
  final RootController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeDependencies();
    if (state == AppLifecycleState.resumed) {
      log('app resumed');
      appResumedOperations();
    }
  }

  Future<void> appResumedOperations() async {
    if (await Permission.location.serviceStatus.isEnabled &&
        await Permission.location.status == PermissionStatus.granted) {
      await controller.getLocation();
    }
  }

  void appInactiveOperations() {}

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar(
      items: [
        NavItem(
          tab: controller.items[0],
          icon: FlutterRemix.road_map_fill,
          title: 'Map',
          navigatorkey: controller.mapNavigatorKey,
        ),
        NavItem(
          tab: controller.items[1],
          icon: FlutterRemix.fire_fill,
          title: 'Feeds',
          navigatorkey: controller.feedsNavigatorKey,
        ),
        NavItem(
          tab: controller.items[2],
          icon: FlutterRemix.message_3_fill,
          title: 'Conversations',
          navigatorkey: controller.conversationsNavigatorKey,
        ),
        NavItem(
          tab: controller.items[3],
          icon: FlutterRemix.notification_4_fill,
          title: 'Notifications',
          navigatorkey: controller.notificationsNavigatorKey,
        ),
      ],
    );
  }
}
