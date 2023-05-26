import 'dart:developer';

import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_drawer.dart';
import 'package:frontend/widgets/lazyload_stack.dart';
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

class RootScreen extends HookWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      context.theme.appBarTheme.systemOverlayStyle!,
    );

    final controller = Get.put(RootController());

    final appLifecycleState = useAppLifecycleState();

    Future<void> appResumedOperations() async {
      if (await Permission.location.serviceStatus.isEnabled &&
          await Permission.location.status == PermissionStatus.granted) {
        await controller.getLocation();
      }
    }

    void appInactiveOperations() {}

    useEffect(
      () {
        if (appLifecycleState == AppLifecycleState.resumed) {
          log('app resumed');
          appResumedOperations();
        } else if (appLifecycleState == AppLifecycleState.inactive) {
          appInactiveOperations();
        }
        return () {};
      },
      [appLifecycleState],
    );

    return Scaffold(
      extendBody: true,
      body: Obx(
        () => LazyLoadIndexedStack(
          index: controller.selectedTab.value,
          children: controller.items,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
