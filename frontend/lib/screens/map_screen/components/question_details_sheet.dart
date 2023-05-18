// import 'package:get_time_ago/get_time_ago.dart';
// import 'package:meetox/controllers/map_controller.dart';
// import 'package:meetox/core/imports/core_imports.dart';
// import 'package:meetox/core/imports/packages_imports.dart';
// import 'package:meetox/helpers/get_distance.dart';
// import 'package:meetox/models/question_model.dart';

// class QuestionDetailsSheet extends GetView<MapScreenController> {
//   final QuestionModel question;
//   final ValueNotifier<bool> isMarkerTapped;

//   QuestionDetailsSheet(this.question, this.isMarkerTapped);

//   @override
//   Widget build(BuildContext context) {
//     final double currentLatitude =
//         controller.rootController.currentPosition.value.latitude;
//     final double currentLongitude =
//         controller.rootController.currentPosition.value.longitude;
//     final double questionLatitude = question.location!.coordinates![0];
//     final double questionLongitude = question.location!.coordinates![1];

//     final double distanceBtw = getDistance(
//       currentLatitude,
//       currentLongitude,
//       questionLatitude,
//       questionLongitude,
//     );

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       controller.animatedMapMove(
//         LatLng(
//           questionLatitude,
//           questionLongitude,
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
//                 leading: Icon(
//                   FlutterRemix.question_fill,
//                   color: Colors.green,
//                   size: 35.sp,
//                 ),
//                 title: Text(
//                   question.question!.capitalize!,
//                   style: context.theme.textTheme.headline3,
//                 ),
//                 subtitle: Text(
//                   question.location!.address!.capitalize!,
//                   style: context.theme.textTheme.headline6!.copyWith(
//                     color: Colors.grey,
//                   ),
//                 ),
//                 trailing: DecoratedBox(
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryYellow,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 20.sp, vertical: 6.sp),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           FlutterRemix.question_answer_fill,
//                           size: 16.sp,
//                           color: Colors.black,
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           'Answer',
//                           style: context.theme.textTheme.headline6,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         question.answers!.length.toString(),
//                         style: context.theme.textTheme.headline4,
//                       ),
//                       Text(
//                         'Answers',
//                         style: context.theme.textTheme.headline6!
//                             .copyWith(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         GetTimeAgo.parse(question.expiry!),
//                         style: context.theme.textTheme.headline4,
//                       ),
//                       Text(
//                         'Time left',
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
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               FlutterRemix.arrow_up_s_fill,
//                               size: 32.sp,
//                               color: AppColors.primaryYellow,
//                             ),
//                             Text(
//                               question.upvotes!.length.toString(),
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
