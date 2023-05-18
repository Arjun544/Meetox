// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:meetox/controllers/map_controller.dart';
// import 'package:meetox/core/imports/packages_imports.dart';
// import 'package:meetox/queries/user_queries.dart';
// import 'package:meetox/screens/map_screen/components/customer_marker.dart';
// import 'package:meetox/widgets/show_custom_sheet.dart';

// import '../../../core/imports/core_imports.dart';
// import 'user_details_sheet.dart';

// class UsersClusterlayer extends HookWidget {
//   const UsersClusterlayer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final MapScreenController controller = Get.find();

//     final nearByUsersQuery = useQuery(
//       job: UserQueries.nearbyUsersQuery,
//       externalData: {
//         'latitude': currentUser.value.location!.coordinates![0],
//         'longitude': currentUser.value.location!.coordinates![1],
//         'distanceInKM': currentUser.value.isPremium! ? 600 : 300,
//       },
//     );

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       controller.isLoading.value =
//           nearByUsersQuery.isLoading || !nearByUsersQuery.hasData
//               ? true
//               : false;
//     });

//     return nearByUsersQuery.isLoading || !nearByUsersQuery.hasData
//         ? SizedBox.shrink()
//         : ZoomIn(
//             child: MarkerClusterLayerWidget(
//               options: MarkerClusterLayerOptions(
//                 maxClusterRadius: 120,
//                 spiderfySpiralDistanceMultiplier: 2,
//                 circleSpiralSwitchover: 1,
//                 zoomToBoundsOnClick: false,
//                 size: Size(50.sp, 50.sp),
//                 markers: nearByUsersQuery.data!
//                     .map(
//                       (user) => Marker(
//                         point: LatLng(
//                           user.location!.coordinates![0],
//                           user.location!.coordinates![1],
//                         ),
//                         width: 60.sp,
//                         height: 60.sp,
//                         builder: (context) => CustomMarker(
//                             image: user.displayPic!.profile!,
//                             color: Colors.orange,
//                             onPressed: (isTapped) {
//                               controller.isFiltersVisible.value = false;
//                               showCustomSheet(
//                                 context: context,
//                                 child: UserDetailsSheet(
//                                   user,
//                                   isTapped,
//                                 ),
//                               );
//                             }),
//                       ),
//                     )
//                     .toList(),
//                 polygonOptions: PolygonOptions(
//                     borderColor: Colors.green, borderStrokeWidth: 4),
//                 popupOptions: PopupOptions(
//                     popupState: PopupState(),
//                     popupSnap: PopupSnap.markerTop,
//                     popupBuilder: (_, marker) => SizedBox.shrink()),
//                 builder: (context, markers) {
//                   return Container(
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Colors.orange.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Container(
//                       height: 40.sp,
//                       width: 40.sp,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.orange,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Text(
//                         '+${markers.length - 1}',
//                         style: context.theme.textTheme.headline4,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//   }
// }
