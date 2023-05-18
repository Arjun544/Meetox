// import 'dart:developer';

// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:meetox/controllers/map_controller.dart';
// import 'package:meetox/core/imports/packages_imports.dart';
// import 'package:meetox/queries/circle_queries.dart';
// import 'package:meetox/widgets/show_custom_sheet.dart';

// import '../../../core/imports/core_imports.dart';
// import 'circle_details_sheet.dart';
// import 'customer_marker.dart';

// class CirclesClusterlayer extends HookWidget {
//   const CirclesClusterlayer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final MapScreenController controller = Get.find();

//     final nearByCirclesQuery = useQuery(
//       job: CircleQueries.nearbyCirclesJob,
//       externalData: {
//         'latitude': currentUser.value.location!.coordinates![0],
//         'longitude': currentUser.value.location!.coordinates![1],
//         'distanceInKM': currentUser.value.isPremium! ? 600 : 300,
//       },
//     );

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       controller.isLoading.value =
//           nearByCirclesQuery.isLoading || !nearByCirclesQuery.hasData
//               ? true
//               : false;
//     });

//     return nearByCirclesQuery.isLoading || !nearByCirclesQuery.hasData
//         ? SizedBox.shrink()
//         : ZoomIn(
//             child: MarkerClusterLayerWidget(
//               options: MarkerClusterLayerOptions(
//                 maxClusterRadius: 120,
//                 spiderfySpiralDistanceMultiplier: 2,
//                 circleSpiralSwitchover: 1,
//                 zoomToBoundsOnClick: false,
//                 size: Size(50.sp, 50.sp),
//                 markers: nearByCirclesQuery.data!
//                     .map(
//                       (circle) => Marker(
//                         point: LatLng(
//                           circle.location.coordinates![0],
//                           circle.location.coordinates![1],
//                         ),
//                         width: 60.sp,
//                         height: 60.sp,
//                         builder: (context) => CustomMarker(
//                           image: circle.image.image,
//                           color: Colors.lightBlue,
//                           onPressed: (isTapped) {
//                             controller.isFiltersVisible.value = false;
//                             showCustomSheet(
//                               context: context,
//                               child: CircleDetailsSheet(circle, isTapped),
//                             );
//                           },
//                         ),
//                       ),
//                     )
//                     .toList(),
//                 polygonOptions: PolygonOptions(
//                     borderColor: Colors.lightBlue, borderStrokeWidth: 4),
//                 builder: (context, markers) {
//                   return Container(
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Colors.lightBlue.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Container(
//                       height: 40.sp,
//                       width: 40.sp,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.lightBlue,
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
