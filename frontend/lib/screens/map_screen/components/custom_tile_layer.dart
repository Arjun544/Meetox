import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/utils/constants.dart';

class CustomTileLayer extends GetView<MapScreenController> {
  const CustomTileLayer({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Obx(
      () => controller.currentMapStyle.value == 'default'
          ? context.isDarkMode
              ? TileLayer(
                  tileProvider: FMTC.instance('Map dark').getTileProvider(
                        FMTCTileProviderSettings(),
                      ),
                  minZoom: 1,
                  maxZoom: 16,
                  urlTemplate: darkMapUrl,
                  userAgentPackageName: 'Monochrome dark',
                  additionalOptions: {
                    'access_token': mapBoxAccessToken,
                  },
                )
              : TileLayer(
                  tileProvider: FMTC.instance('Map light').getTileProvider(
                        FMTCTileProviderSettings(),
                      ),
                  minZoom: 1,
                  maxZoom: 16,
                  urlTemplate: lightMapUrl,
                  userAgentPackageName: 'Monochrome light',
                  additionalOptions: {
                    'access_token': mapBoxAccessToken,
                  },
                )
          : controller.currentMapStyle.value == 'sky'
              ? TileLayer(
                  tileProvider: FMTC.instance('Map sky').getTileProvider(
                        FMTCTileProviderSettings(),
                      ),
                  minZoom: 1,
                  maxZoom: 16,
                  urlTemplate: skyMapUrl,
                  userAgentPackageName: 'Monochrome sky',
                  additionalOptions: {
                    'access_token': mapBoxAccessToken,
                  },
                )
              : TileLayer(
                  tileProvider: FMTC.instance('Map meetox').getTileProvider(
                        FMTCTileProviderSettings(),
                      ),
                  minZoom: 1,
                  maxZoom: 16,
                  urlTemplate: meetoxMapUrl,
                  userAgentPackageName: 'Monochrome meetox',
                  additionalOptions: {
                    'access_token': mapBoxAccessToken,
                  },
                ),
    );
  }
}
