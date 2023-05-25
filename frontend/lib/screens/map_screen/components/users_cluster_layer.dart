import 'dart:convert';

import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/user/queries.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/map_screen/components/customer_marker.dart';
import 'package:frontend/screens/map_screen/components/user_details_sheet.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UsersClusterlayer extends GetView<MapScreenController> {
  const UsersClusterlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(getNearByUsers),
        variables: {
          'latitude': currentUser.value.location!.coordinates![0],
          'longitude': currentUser.value.location!.coordinates![1],
          'distanceInKM': currentUser.value.isPremium! ? 600 : 300,
          'followers': const [],
        },
        onError: (error) => logError(error!.toString()),
      ),
      builder: (result, {fetchMore, refetch}) {
        final users = result.data!['getNearByUsers']
            .map<User>((user) => User.fromRawJson(json.encode(user)))
            .toList() as List<User>;

        return ZoomIn(
          child: MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 120,
              spiderfySpiralDistanceMultiplier: 2,
              circleSpiralSwitchover: 1,
              zoomToBoundsOnClick: false,
              size: Size(50.sp, 50.sp),
              markers: users
                  .map(
                    (user) => Marker(
                      point: LatLng(
                        user.location!.coordinates![0],
                        user.location!.coordinates![1],
                      ),
                      width: 60.sp,
                      height: 60.sp,
                      builder: (context) => CustomMarker(
                        image: user.displayPic!.profile!,
                        color: Colors.orange,
                        onPressed: (isTapped) {
                          controller.isFiltersVisible.value = false;
                          showCustomSheet(
                            context: context,
                            child: UserDetailsSheet(
                              user,
                              isTapped,
                            ),
                          );
                        },
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
        );
      },
    );
  }
}
