// import 'package:meetox/controllers/map_controller.dart';
// import 'package:meetox/core/imports/core_imports.dart';
// import 'package:meetox/core/imports/packages_imports.dart';
// import 'package:meetox/helpers/get_distance.dart';
// import 'package:meetox/models/circle_model.dart' as circle_model;

// class CircleDetailsSheet extends GetView<MapScreenController> {
//   final circle_model.Circle circle;
//   final ValueNotifier<bool> isMarkerTapped;

//   CircleDetailsSheet(this.circle, this.isMarkerTapped);

//   @override
//   Widget build(BuildContext context) {
//     final double currentLatitude =
//         controller.rootController.currentPosition.value.latitude;
//     final double currentLongitude =
//         controller.rootController.currentPosition.value.longitude;
//     final double circleLatitude = circle.location.coordinates![0];
//     final double circleLongitude = circle.location.coordinates![1];

//     final double distanceBtw = getDistance(
//       currentLatitude,
//       currentLongitude,
//       circleLatitude,
//       circleLongitude,
//     );

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       controller.animatedMapMove(
//         LatLng(
//           circleLatitude,
//           circleLongitude,
//         ),
//         14,
//       );
//     });
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () {
//         controller.isFiltersVisible.value = true;
//         isMarkerTapped.value = false;
//         Get.back();
//       },
//       child: Container(
//         height: Get.height,
//         width: Get.width,
//         color: Colors.transparent,
//         child: Container(
//           height: Get.height * 0.4,
//           width: Get.width,
//           margin: EdgeInsets.only(top: Get.height * 0.6),
//           decoration: BoxDecoration(
//             color: context.theme.scaffoldBackgroundColor,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Center(
//                 child: Container(
//                   height: 5.sp,
//                   width: 70.sp,
//                   decoration: BoxDecoration(
//                     color:
//                         context.theme.bottomNavigationBarTheme.backgroundColor,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 dense: true,
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: CachedNetworkImage(
//                     imageUrl: circle.image.image,
//                     // height: 170.sp,
//                     width: 50.sp,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 title: Text(
//                   circle.name.capitalize!,
//                   style: context.theme.textTheme.headline3,
//                 ),
//                 subtitle: Text(
//                   circle.location.address!.capitalize!,
//                   style: context.theme.textTheme.headline6!.copyWith(
//                     color: Colors.grey,
//                   ),
//                 ),
//                 trailing: !circle.isPrivate
//                     ? DecoratedBox(
//                         decoration: BoxDecoration(
//                           color: AppColors.primaryYellow,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20.sp, vertical: 6.sp),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 FlutterRemix.login_circle_fill,
//                                 size: 16.sp,
//                                 color: Colors.black,
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 'Join',
//                                 style: context.theme.textTheme.headline6,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : DecoratedBox(
//                         decoration: BoxDecoration(
//                           color: context.theme.backgroundColor,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 12.sp, vertical: 10.sp),
//                           child: Icon(
//                             FlutterRemix.door_lock_fill,
//                             size: 16.sp,
//                             color: context.theme.iconTheme.color,
//                           ),
//                         ),
//                       ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         circle.members.length.toString(),
//                         style: context.theme.textTheme.headline4,
//                       ),
//                       Text(
//                         'Members',
//                         style: context.theme.textTheme.headline6!
//                             .copyWith(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         circle.limit.toString(),
//                         style: context.theme.textTheme.headline4,
//                       ),
//                       Text(
//                         'Limit',
//                         style: context.theme.textTheme.headline6!
//                             .copyWith(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         height: 45.sp,
//                         decoration: BoxDecoration(
//                           color: context.theme.backgroundColor,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Icon(
//                               FlutterRemix.pin_distance_fill,
//                               size: 22.sp,
//                               color: context.theme.iconTheme.color,
//                             ),
//                             Text(
//                               '~ ${distanceBtw.toStringAsFixed(0)} KMs',
//                               style: context.theme.textTheme.headline6,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: Container(
//                         height: 45.sp,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: context.theme.backgroundColor,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           circle.isPrivate ? 'Private' : 'Public',
//                           style: context.theme.textTheme.headline6,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: Container(
//                         height: 45.sp,
//                         decoration: BoxDecoration(
//                           color: context.theme.backgroundColor,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           FlutterRemix.profile_fill,
//                           size: 22.sp,
//                           color: context.theme.iconTheme.color,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 50.sp,
//                 width: Get.width,
//                 margin:
//                     EdgeInsets.only(right: 15.sp, left: 15.sp, bottom: 15.sp),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryYellow,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       FlutterRemix.treasure_map_fill,
//                       size: 18.sp,
//                       color: context.theme.iconTheme.color,
//                     ),
//                     SizedBox(width: 20),
//                     Text(
//                       'Navigate',
//                       style: context.theme.textTheme.headline5,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
