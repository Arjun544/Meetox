import 'dart:io';

import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/screens/map_screen/components/custom_tile_layer.dart';
import 'package:frontend/screens/map_screen/components/main_filters.dart';
import 'package:frontend/widgets/top_bar.dart';

import 'components/current_user_layer.dart';
import 'components/users_cluster_layer.dart';

class MapScreen extends GetView<MapScreenController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MapScreenController());
    controller.mapController = MapController();

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                center: LatLng(
                  controller.rootController.currentPosition.value.latitude,
                  controller.rootController.currentPosition.value.longitude,
                ),
                zoom: 16,
                minZoom: 1,
                maxZoom: 16,
                keepAlive: true,
                interactiveFlags:
                    InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                onMapReady: () {
                  controller.animatedMapMove(
                    LatLng(
                      controller.rootController.currentPosition.value.latitude,
                      controller.rootController.currentPosition.value.longitude,
                    ),
                    14,
                  );
                },
                maxBounds: controller.rootController.mapBounds.value,
                boundsOptions: const FitBoundsOptions(inside: true),
                onMapEvent: (event) {
                  if (event.source.name == 'onDrag' &&
                      controller.isDraggingMap.value == false) {
                    controller.isDraggingMap.value = true;
                  } else if (event.source.name == 'dragEnd' &&
                      controller.isDraggingMap.value == true) {
                    controller.isDraggingMap.value = false;
                  }
                },
              ),
              children: controller.currentMainFilter.value == 'All'
                  ? [
                      const CustomTileLayer(),
                      const CurrentUserLayer(),
                      // const CirclesClusterlayer(),
                      const UsersClusterlayer(),
                      // const FollowersClusterlayer(),
                      // const QuestionsClusterlayer(),
                    ]
                  : controller.currentMainFilter.value == 'Circles'
                      ? [
                          const CustomTileLayer(),
                          // const CurrentUserLayer(),
                          // const CirclesClusterlayer(),
                        ]
                      : controller.currentMainFilter.value == 'Questions'
                          ? [
                              const CustomTileLayer(),
                              // const CurrentUserLayer(),
                              // const QuestionsClusterlayer(),
                            ]
                          : controller.currentMainFilter.value == 'Followers'
                              ? [
                                  const CustomTileLayer(),
                                  // const CurrentUserLayer(),
                                  // const FollowersClusterlayer(),
                                ]
                              : [
                                  const CustomTileLayer(),
                                  // const CurrentUserLayer(),
                                  // const UsersClusterlayer(),
                                ],
            ),
          ),
          Obx(
            () => !controller.isDraggingMap.value
                ? SlideInDown(
                    child: TopBar(
                      isMapScreen: true,
                      isPrecise: controller.isLocationPrecise,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isCurrentFilterMarkVisible.value
                ? Positioned(
                    left: 15.sp,
                    top: 120.sp,
                    child: SlideInLeft(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.theme.cardColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: Text(
                            controller.currentMainFilter.value,
                            style: context.theme.textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => !controller.isDraggingMap.value
                ? Positioned(
                    right: 0,
                    top: 150.sp,
                    child: SlideInRight(
                      child: const MainFilters(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            left: 15,
            bottom: 115.sp,
            child: Obx(
              () => controller.isLoading.value
                  ? Container(
                      height: 50.sp,
                      width: 50.sp,
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      decoration: BoxDecoration(
                        color: AppColors.primaryYellow.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.customBlack,
                        size: 20.sp,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: Platform.isIOS ? 70.sp : 80.sp),
        child: Obx(
          () => !controller.isDraggingMap.value
              ? SlideInRight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        elevation: 0,
                        backgroundColor: context
                            .theme.floatingActionButtonTheme.backgroundColor,
                        child: Icon(
                          IconsaxBold.textalign_center,
                          color: context.theme.appBarTheme.iconTheme!.color,
                        ),
                        onPressed: () {},
                        // TODO:
                        // onPressed: () => showCustomSheet(
                        //   context: context,
                        //   child: MarkersListSheet(),
                        // ),
                      ),
                      const SizedBox(height: 14),
                      FloatingActionButton(
                        elevation: 0,
                        backgroundColor: context
                            .theme.floatingActionButtonTheme.backgroundColor,
                        child: Icon(
                          FlutterRemix.focus_fill,
                          color: context.theme.appBarTheme.iconTheme!.color,
                        ),
                        onPressed: () async {
                          // final double distance = Geolocator.distanceBetween(
                          //   controller.rootController.currentPosition.value.latitude - 1,
                          //   controller.rootController.currentPosition.value.longitude - 1,
                          //   controller.rootController.currentPosition.value.latitude + 1,
                          //   controller.rootController.currentPosition.value.longitude + 1,
                          // );
                          // log('distance: ${(distance * 0.001).toStringAsFixed(0)}');
                          controller.animatedMapMove(
                            LatLng(
                              controller.rootController.currentPosition.value
                                  .latitude,
                              controller.rootController.currentPosition.value
                                  .longitude,
                            ),
                            15,
                          );
                          // int tiles = FMTC.instance('Map store').stats.storeLength;

                          // final int checkTiles = FMTC.instance('Map light').stats.storeLength;
                          // final bool isCachaed = FMTC
                          //     .instance('Map light')
                          //     .getTileProvider(
                          //       FMTCTileProviderSettings(behavior: CacheBehavior.cacheFirst),
                          //     )
                          //     .checkTileCached(
                          //       coords: Coords(
                          //           controller.rootController.currentPosition.value.latitude,
                          //           controller
                          //               .rootController.currentPosition.value.longitude),
                          //       options: TileLayer(
                          //         tileProvider: FMTC.instance('Map light').getTileProvider(
                          //               FMTCTileProviderSettings(
                          //                   behavior: CacheBehavior.cacheFirst),
                          //             ),
                          //         minZoom: 1,
                          //         maxZoom: 14,
                          //         tileBounds: controller.rootController.mapBounds.value,
                          //         urlTemplate: lightMapUrl,
                          //       ),
                          //       customURL: lightMapUrl,
                          //     );
                          // log('tiles: ');
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
