import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/map_screen/components/follower_marker.dart';

class FollowersClusterlayer extends GetView<MapScreenController> {
  const FollowersClusterlayer(this.followers, {super.key});

  final List<User> followers;

  @override
  Widget build(BuildContext context) {
    final tappedFollower = User().obs;
    return ZoomIn(
      child: Obx(
        () => MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            spiderfySpiralDistanceMultiplier: 2,
            circleSpiralSwitchover: 1,
            zoomToBoundsOnClick: false,
            size: Size(50.sp, 50.sp),
            markers: tappedFollower.value.id != null
                ? [
                    Marker(
                      point: LatLng(
                        tappedFollower.value.location!.coordinates![0],
                        tappedFollower.value.location!.coordinates![1],
                      ),
                      width: 60.sp,
                      height: 60.sp,
                      builder: (context) => FollowerMarker(
                        follower: tappedFollower.value,
                        tappedFollower: tappedFollower,
                      ),
                    )
                  ]
                : followers
                    .map(
                      (follower) => Marker(
                        point: LatLng(
                          follower.location!.coordinates![0],
                          follower.location!.coordinates![1],
                        ),
                        width: 60.sp,
                        height: 60.sp,
                        builder: (context) => FollowerMarker(
                          follower: follower,
                          tappedFollower: tappedFollower,
                        ),
                      ),
                    )
                    .toList(),
            polygonOptions: const PolygonOptions(
              borderColor: AppColors.primaryYellow,
              borderStrokeWidth: 4,
            ),
            popupOptions: PopupOptions(
              popupState: PopupState(),
              popupBuilder: (_, marker) => const SizedBox.shrink(),
            ),
            builder: (context, markers) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 40.sp,
                  width: 40.sp,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryYellow,
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
