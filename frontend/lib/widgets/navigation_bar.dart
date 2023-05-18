import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/widgets/lazyload_stack.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

import 'sheets/add_options_sheet.dart';

class CustomBottomNavigationBar extends GetView<RootController> {
  const CustomBottomNavigationBar({required this.items, super.key});
  final List<NavItem> items;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (items[controller.selectedTab.value]
                .navigatorkey
                ?.currentState
                ?.canPop() ??
            false) {
          items[controller.selectedTab.value].navigatorkey?.currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Obx(
          () => LazyLoadIndexedStack(
            index: controller.selectedTab.value,
            children: items
                .map(
                  (page) => Navigator(
                    key: page.navigatorkey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.tab)
                      ];
                    },
                  ),
                )
                .toList(),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppColors.primaryYellow,
        //   child: Icon(
        //     FlutterRemix.add_fill,
        //     size: 25.sp,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {},
        // ),
        bottomNavigationBar: Obx(
          () => CustomNavigationBar(
            // iconSize: 15.h,
            scaleFactor: 0.4,
            isFloating: true,
            elevation: 2,
            borderRadius: const Radius.circular(16),
            selectedColor: AppColors.primaryYellow,
            unSelectedColor: AppColors.customGrey,
            backgroundColor: Colors.black,
            currentIndex: controller.selectedTab.value,
            strokeColor: AppColors.primaryYellow,
            items: items
                .map(
                  (item) => CustomNavigationBarItem(
                    selectedIcon: item.title == 'Add'
                        ? null
                        : Icon(
                            item.icon,
                            size: 24,
                            color: AppColors.primaryYellow,
                          ),
                    icon: item.title == 'Add'
                        ? OverflowBox(
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
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Icon(
                            item.unselectedIcon,
                            size: 24,
                            color: context.theme.bottomNavigationBarTheme
                                .unselectedItemColor,
                          ),
                  ),
                )
                .toList(),
            onTap: (index) {
              if (index == 2) {
                showCustomSheet(
                    context: context, child: const AddOptionsSheet());
              } else if (index == controller.selectedTab.value) {
                items[index]
                    .navigatorkey
                    ?.currentState
                    ?.popUntil((route) => route.isFirst);
              } else {
                controller.selectedTab.value = index;
              }
            },
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
    required this.unselectedIcon,
    this.navigatorkey,
  });
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;
  final IconData unselectedIcon;
}
