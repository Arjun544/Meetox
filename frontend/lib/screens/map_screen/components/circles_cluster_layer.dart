import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;

import '../../../core/imports/core_imports.dart';
import 'custom_circle_marker.dart';

class CirclesClusterlayer extends GetView<MapScreenController> {
  const CirclesClusterlayer(this.circles, {super.key});

  final List<circle_model.Circle> circles;

  @override
  Widget build(BuildContext context) {
    final tappedCircle = circle_model.Circle().obs;

    return ZoomIn(
      child: Obx(
        () => MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            spiderfySpiralDistanceMultiplier: 2,
            circleSpiralSwitchover: 1,
            zoomToBoundsOnClick: false,
            size: Size(50.sp, 50.sp),
            markers: tappedCircle.value.id != null
                ? [
                    Marker(
                      point: LatLng(
                        tappedCircle.value.location!.coordinates![0],
                        tappedCircle.value.location!.coordinates![1],
                      ),
                      width: 60.sp,
                      height: 60.sp,
                      builder: (context) => CustomCircleMarker(
                        circle: tappedCircle.value,
                        tappedCircle: tappedCircle,
                      ),
                    )
                  ]
                : circles
                    .map(
                      (circle) => Marker(
                        point: LatLng(
                          circle.location!.coordinates![0],
                          circle.location!.coordinates![1],
                        ),
                        width: 60.sp,
                        height: 60.sp,
                        builder: (context) => CustomCircleMarker(
                          circle: circle,
                          tappedCircle: tappedCircle,
                        ),
                      ),
                    )
                    .toList(),
            polygonOptions: const PolygonOptions(
                borderColor: Colors.lightBlue, borderStrokeWidth: 4),
            builder: (context, markers) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 40.sp,
                  width: 40.sp,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '+${markers.length - 1}',
                    style: context.theme.textTheme.labelMedium,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
