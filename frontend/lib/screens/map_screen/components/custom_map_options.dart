import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/instances.dart';
import 'package:frontend/widgets/custom_tabbar.dart';
import 'package:frontend/widgets/mini_map.dart';

class CustomMapOptions extends StatelessWidget {
  const CustomMapOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final rootController = Get.find();
    final mapScreenController = Get.find();

    Future<void> handleMapStyleChange(int value) async {
      if (value == 0) {
        mapScreenController.currentMapStyle.value = 'default';
        await getStorage.write('currentMapStyle', 'default');
      } else if (value == 1) {
        mapScreenController.currentMapStyle.value = 'sky';
        await getStorage.write('currentMapStyle', 'sky');
      } else {
        mapScreenController.currentMapStyle.value = 'meetox';
        await getStorage.write('currentMapStyle', 'meetox');
      }
    }

    final tabController = useTabController(
      initialIndex: mapScreenController.currentMapStyle.value == 'default'
          ? 0
          : mapScreenController.currentMapStyle.value == 'sky'
              ? 1
              : 2,
      initialLength: 3,
    );

    return Container(
      height: Get.height * 0.45,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SizedBox(height: 10.sp),
          Center(
            child: Container(
              height: 5.sp,
              width: 70.sp,
              decoration: BoxDecoration(
                color: context.theme.bottomNavigationBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Text(
            'Map styles',
            style: context.theme.textTheme.labelSmall,
          ),
          // SizedBox(height: 10.sp),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 200.sp,
              width: Get.width,
              child: MiniMap(
                latitude:
                    rootController.currentPosition.value.latitude as double,
                longitude:
                    rootController.currentPosition.value.longitude as double,
              ),
            ),
          ),
          // SizedBox(height: 10.sp),
          CustomTabbar(
            controller: tabController,
            onTap: handleMapStyleChange,
            tabs: const [
              Tab(
                text: 'Default',
              ),
              Tab(
                text: 'Sky',
              ),
              Tab(
                text: 'Meetox',
              ),
            ],
          ),
          // Container(
          //   width: Get.width,
          //   height: 40.sp,
          //   decoration: BoxDecoration(
          //     color: context.isDarkMode ? Colors.black : AppColors.customGrey,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: TabBar(
          //     controller: tabController,
          //     indicatorColor: Colors.green,
          //     onTap: handleMapStyleChange,
          //     tabs: const [
          //       Tab(
          //         text: 'Default',
          //       ),
          //       Tab(
          //         text: 'Sky',
          //       ),
          //       Tab(
          //         text: 'Meetox',
          //       ),
          //     ],
          //     labelStyle: context.theme.textTheme.labelSmall!
          //         .copyWith(letterSpacing: 1),
          //     unselectedLabelStyle: context.theme.textTheme.labelSmall!
          //         .copyWith(letterSpacing: 1),
          //     labelColor: context.theme.textTheme.labelMedium!.color,
          //     indicator: RectangularIndicator(
          //       color: AppColors.primaryYellow,
          //       bottomLeftRadius: 12,
          //       bottomRightRadius: 12,
          //       topLeftRadius: 12,
          //       topRightRadius: 12,
          //       verticalPadding: 4,
          //       horizontalPadding: 4,
          //       paintingStyle: PaintingStyle.fill,
          //     ),
          //   ),
          // ),
          SizedBox(height: 20.sp),
        ],
      ),
    );
  }
}
