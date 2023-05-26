import 'dart:io';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';

import 'package:frontend/widgets/sheets/add_options_sheet.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

class CustomBottomNavigationBar extends GetView<RootController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <NavItem>[
      NavItem(
        tab: controller.items[0],
        icon: IconsaxBold.map_1,
        title: 'Map',
      ),
      NavItem(
        tab: controller.items[1],
        icon: FlutterRemix.fire_fill,
        title: 'Feeds',
      ),
      NavItem(
        tab: controller.items[2],
        icon: FlutterRemix.add_fill,
        title: 'Add',
      ),
      NavItem(
        tab: controller.items[3],
        icon: IconsaxBold.message,
        title: 'Conversations',
      ),
      NavItem(
        tab: controller.items[4],
        icon: IconsaxBold.notification,
        title: 'Notifications',
      ),
    ];
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(bottom: Platform.isAndroid ? 16.0.sp : 0),
        child: SizedBox(
          height: Platform.isIOS ? Get.width * 0.25 : Get.width * 0.15,
          child: CustomNavigationBar(
            iconSize: 24.sp,
            scaleFactor: 0.4,
            isFloating: true,
            elevation: 2,
            borderRadius: const Radius.circular(16),
            selectedColor: AppColors.primaryYellow,
            strokeColor: Colors.transparent,
            unSelectedColor: AppColors.customGrey,
            backgroundColor: Colors.black,
            currentIndex: controller.selectedTab.value,
            onTap: (index) {
              if (index == 2) {
                showCustomSheet(
                  context: context,
                  child: const AddOptionsSheet(),
                );
              } else {
                controller.selectedTab.value = index;
              }
            },
            items: items
                .map(
                  (item) => CustomNavigationBarItem(
                    icon: item.title != 'Add'
                        ? Icon(
                            item.icon,
                            size: 22.h,
                            color: controller.selectedTab.value ==
                                    items.indexOf(item)
                                ? context.theme.bottomNavigationBarTheme
                                    .selectedItemColor
                                : context.theme.bottomNavigationBarTheme
                                    .unselectedItemColor,
                          )
                        : OverflowBox(
                            maxHeight: 100,
                            maxWidth: 100,
                            child: Container(
                              height: 30.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryYellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                item.icon,
                                size: 22.h,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class NavItem {
  NavItem({
    required this.tab,
    required this.title,
    required this.icon,
  });
  final Widget tab;
  final String title;
  final IconData icon;
}
