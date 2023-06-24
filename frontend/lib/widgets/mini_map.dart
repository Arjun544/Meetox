import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/helpers/get_distance.dart';
import 'package:frontend/screens/map_screen/components/current_user_marker.dart';
import 'package:frontend/utils/constants.dart';

class MiniMap extends GetView<MapScreenController> {
  const MiniMap({required this.latitude, required this.longitude, super.key});
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    Get.put(MapScreenController());

    final currentLatitude =
        controller.rootController.currentPosition.value.latitude;
    final currentLongitude =
        controller.rootController.currentPosition.value.longitude;

    final distanceBtw = getDistance(
      currentLatitude,
      currentLongitude,
      latitude,
      longitude,
    );
    return Stack(
      children: [
        Obx(
          () => FlutterMap(
            options: MapOptions(
              center: LatLng(
                latitude,
                longitude,
              ),
              zoom: 12,
              minZoom: 1,
              maxZoom: 12,
              keepAlive: true,
              interactiveFlags: InteractiveFlag.none,
              onMapReady: () {},
            ),
            children: [
              if (controller.currentMapStyle.value == 'default')
                context.isDarkMode
                    ? TileLayer(
                        tileProvider: FMTC.instance('Map dark').getTileProvider(
                              FMTCTileProviderSettings(),
                            ),
                        minZoom: 1,
                        maxZoom: 12,
                        urlTemplate: darkMapUrl,
                        userAgentPackageName: 'Monochrome dark',
                        additionalOptions: {
                          'access_token': mapBoxAccessToken,
                        },
                      )
                    : TileLayer(
                        tileProvider:
                            FMTC.instance('Map light').getTileProvider(
                                  FMTCTileProviderSettings(),
                                ),
                        minZoom: 1,
                        maxZoom: 12,
                        urlTemplate: lightMapUrl,
                        userAgentPackageName: 'Monochrome light',
                        additionalOptions: {
                          'access_token': mapBoxAccessToken,
                        },
                      )
              else
                controller.currentMapStyle.value == 'sky'
                    ? TileLayer(
                        tileProvider: FMTC.instance('Map sky').getTileProvider(
                              FMTCTileProviderSettings(),
                            ),
                        minZoom: 1,
                        maxZoom: 12,
                        urlTemplate: skyMapUrl,
                        userAgentPackageName: 'Monochrome sky',
                        additionalOptions: {
                          'access_token': mapBoxAccessToken,
                        },
                      )
                    : TileLayer(
                        tileProvider:
                            FMTC.instance('Map meetox').getTileProvider(
                                  FMTCTileProviderSettings(),
                                ),
                        minZoom: 1,
                        maxZoom: 12,
                        urlTemplate: meetoxMapUrl,
                        userAgentPackageName: 'Monochrome meetox',
                        additionalOptions: {
                          'access_token': mapBoxAccessToken,
                        },
                      ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      controller.rootController.currentPosition.value.latitude,
                      controller.rootController.currentPosition.value.longitude,
                    ),
                    width: 60.sp,
                    height: 60.sp,
                    builder: (context) => const CurrentUserMarker(
                      isMiniMap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FlutterRemix.pin_distance_fill,
                size: 18,
                color: context.theme.iconTheme.color,
              ),
              SizedBox(width: 10),
              Text(
                '~ ${distanceBtw.toStringAsFixed(0)} KMs',
                style: context.theme.textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
