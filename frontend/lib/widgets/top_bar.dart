import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/instances.dart';
import 'package:frontend/widgets/user_initials.dart';

class TopBar extends GetView<MapScreenController> {
  const TopBar({
    required this.isPrecise,
    super.key,
    this.isMapScreen = false,
    this.topPadding = 50,
  });
  final bool isMapScreen;
  final RxBool isPrecise;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_positional_boolean_parameters
    Future<void> onPreciseChange(bool val) async {
      isPrecise.value = val;
      controller.rootController.currentPosition.value =
          await Geolocator.getCurrentPosition(
        desiredAccuracy: val ? LocationAccuracy.best : LocationAccuracy.lowest,
      );
      await getStorage.write('isPrecise', val);

      final placemarks = await placemarkFromCoordinates(
        controller.rootController.currentPosition.value.latitude,
        controller.rootController.currentPosition.value.longitude,
      );

      final address =
          '${placemarks[0].administrativeArea}, ${placemarks[0].isoCountryCode}';
      controller.rootController.currentAddress.value = address;

      // final UserModel userData = await UserServices.addLocation(
      //   address: address,
      //   latitude: controller.rootController.currentPosition.value.latitude,
      //   longitude: controller.rootController.currentPosition.value.longitude,
      // );

      // currentUser.value = userData.user;
      controller.animatedMapMove(
        LatLng(
          controller.rootController.currentPosition.value.latitude,
          controller.rootController.currentPosition.value.longitude,
        ),
        15,
      );
    }

    final rootController = Get.find<RootController>();

    return Container(
      height: 55.sp,
      width: Get.width,
      // color: Colors.white,
      margin: EdgeInsets.only(
        top: Platform.isIOS ? topPadding.sp : 40.sp,
        right: 15.sp,
        left: 15.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => rootController.zoomDrawerController.open!(),
            child: Hero(
              tag: 'Profile',
              child: currentUser.value.displayPic == null
                  ? UserInititals(name: currentUser.value.name!)
                  : Container(
                      height: 45.sp,
                      width: 45.sp,
                      decoration: BoxDecoration(
                        color: context.theme.dividerColor,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: context.isDarkMode
                                ? Colors.black
                                : Colors.grey[400]!,
                            blurRadius: 0.3,
                          ),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            currentUser.value.displayPic!.profile!,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          if (isMapScreen)
            Row(
              children: [
                Text('Precise', style: context.theme.textTheme.labelSmall),
                SizedBox(width: 10.sp),
                Transform.scale(
                  scale: 0.7,
                  child: Obx(
                    () => CupertinoSwitch(
                      value: isPrecise.value,
                      trackColor: Colors.black,
                      activeColor: AppColors.primaryYellow,
                      onChanged: onPreciseChange,
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current location',
                  style: context.theme.textTheme.labelSmall,
                ),
                SizedBox(height: 5.sp),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      IconsaxBold.location,
                      size: 15.sp,
                    ),
                    SizedBox(width: 5.sp),
                    Obx(
                      () => Text(
                        currentUser.value.location == null
                            ? 'Unknown'
                            : currentUser.value.location!.address!,
                        style: context.theme.textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(width: 5.sp),
                  ],
                ),
              ],
            ),
          Row(
            children: [
              if (isMapScreen)
                InkWell(
                  onTap: () {},
                  // onTap: () => showCustomSheet(
                  //   context: context,
                  //   child: CustomMapOptions(),
                  // ),
                  child: Container(
                    height: 40.sp,
                    width: 40.sp,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 10.sp),
                    decoration: BoxDecoration(
                      color: context.theme.dividerColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: context.isDarkMode
                              ? Colors.black
                              : Colors.grey[400]!,
                          blurRadius: 0.3,
                        ),
                      ],
                    ),
                    child: const Icon(IconsaxBold.setting),
                  ),
                ),
              Container(
                height: 40.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  color: context.theme.dividerColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color:
                          context.isDarkMode ? Colors.black : Colors.grey[400]!,
                      blurRadius: 0.3,
                    ),
                  ],
                ),
                child: const Icon(IconsaxBold.search_normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
