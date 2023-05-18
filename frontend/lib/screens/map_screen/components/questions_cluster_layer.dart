// import 'dart:developer';

// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:meetox/controllers/map_controller.dart';
// import 'package:meetox/core/imports/packages_imports.dart';
// import 'package:meetox/queries/question_queries.dart';
// import 'package:meetox/screens/map_screen/components/customer_marker.dart';
// import 'package:meetox/widgets/show_custom_sheet.dart';

// import '../../../core/imports/core_imports.dart';
// import 'question_details_sheet.dart';

// class QuestionsClusterlayer extends HookWidget {
//   const QuestionsClusterlayer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final MapScreenController controller = Get.find();

//     final nearByQuestionsQuery = useQuery(
//       job: QuestionQueries.nearbyQuestionsQuery,
//       externalData: {
//         'latitude': currentUser.value.location!.coordinates![0],
//         'longitude': currentUser.value.location!.coordinates![1],
//         'distanceInKM': currentUser.value.isPremium! ? 600 : 300,
//       },
//     );

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       controller.isLoading.value =
//           nearByQuestionsQuery.isLoading || !nearByQuestionsQuery.hasData
//               ? true
//               : false;
//     });

//     if (nearByQuestionsQuery.isLoading || !nearByQuestionsQuery.hasData) {
//       return SizedBox.shrink();
//     } else {
//       return ZoomIn(
//         child: MarkerClusterLayerWidget(
//           options: MarkerClusterLayerOptions(
//             maxClusterRadius: 120,
//             spiderfySpiralDistanceMultiplier: 2,
//             circleSpiralSwitchover: 1,
//             zoomToBoundsOnClick: false,
//             size: Size(50.sp, 50.sp),
//             markers: nearByQuestionsQuery.data!
//                 .map(
//                   (question) => Marker(
//                     point: LatLng(
//                       question.location!.coordinates![0],
//                       question.location!.coordinates![1],
//                     ),
//                     width: 60.sp,
//                     height: 60.sp,
//                     builder: (context) => CustomMarker(
//                       image: '',
//                       isQuestionMarker: true,
//                       color: Colors.green,
//                       onPressed: (isTapped) {
//                         controller.isFiltersVisible.value = false;
//                         showCustomSheet(
//                           context: context,
//                           child: QuestionDetailsSheet(
//                             question,
//                             isTapped,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 )
//                 .toList(),
//             polygonOptions:
//                 PolygonOptions(borderColor: Colors.green, borderStrokeWidth: 4),
//             builder: (context, markers) {
//               return Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.5),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Container(
//                   height: 40.sp,
//                   width: 40.sp,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Text(
//                     '+${markers.length - 1}',
//                     style: context.theme.textTheme.headline4,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//     }
//   }
// }
