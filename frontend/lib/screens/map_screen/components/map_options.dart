import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/instances.dart';
import 'package:frontend/widgets/custom_tabbar.dart';
import 'package:frontend/widgets/mini_map.dart';

class CustomMapOptions extends HookWidget {
  const CustomMapOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final MapScreenController controller = Get.find();
    Future<void> handleMapStyleChange(int value) async {
      if (value == 0) {
        controller.currentMapStyle.value = 'default';
        await getStorage.write('currentMapStyle', 'default');
      } else if (value == 1) {
        controller.currentMapStyle.value = 'sky';
        await getStorage.write('currentMapStyle', 'sky');
      } else {
        controller.currentMapStyle.value = 'meetox';
        await getStorage.write('currentMapStyle', 'meetox');
      }
    }

    final tabController = useTabController(
      initialIndex: controller.currentMapStyle.value == 'default'
          ? 0
          : controller.currentMapStyle.value == 'sky'
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
                latitude: currentUser.value.location!.coordinates![0],
                longitude: currentUser.value.location!.coordinates![1],
              ),
            ),
          ),
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
          SizedBox(height: 20.sp),
        ],
      ),
    );
  }
}
