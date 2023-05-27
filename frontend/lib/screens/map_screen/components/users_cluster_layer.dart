import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/map_screen/components/custom_user_marker.dart';

class UsersClusterlayer extends GetView<MapScreenController> {
  const UsersClusterlayer(this.users, {super.key});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    final tappedUser = User().obs;
    return ZoomIn(
      child: Obx(
        () => MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            spiderfySpiralDistanceMultiplier: 2,
            circleSpiralSwitchover: 1,
            zoomToBoundsOnClick: false,
            size: Size(50.sp, 50.sp),
            markers: tappedUser.value.id != null
                ? [
                    Marker(
                      point: LatLng(
                        tappedUser.value.location!.coordinates![0],
                        tappedUser.value.location!.coordinates![1],
                      ),
                      width: 60.sp,
                      height: 60.sp,
                      builder: (context) => CustomUserMarker(
                        user: tappedUser.value,
                        tappedUser: tappedUser,
                      ),
                    )
                  ]
                : users
                    .map(
                      (user) => Marker(
                        point: LatLng(
                          user.location!.coordinates![0],
                          user.location!.coordinates![1],
                        ),
                        width: 60.sp,
                        height: 60.sp,
                        builder: (context) => CustomUserMarker(
                          user: user,
                          tappedUser: tappedUser,
                        ),
                      ),
                    )
                    .toList(),
            polygonOptions: const PolygonOptions(
              borderColor: Colors.green,
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
                  color: Colors.orange.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 40.sp,
                  width: 40.sp,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
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
