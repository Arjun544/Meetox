// import 'dart:convert';

// import 'package:frontend/controllers/map_controller.dart';
// import 'package:frontend/core/imports/core_imports.dart';
// import 'package:frontend/core/imports/packages_imports.dart';
// import 'package:frontend/helpers/get_distance.dart';
// import 'package:frontend/models/circle_model.dart' as circle_model;
// import 'package:frontend/models/question_model.dart';
// import 'package:frontend/models/user_model.dart';
// import 'package:frontend/widgets/custom_button.dart';
// import 'package:frontend/widgets/custom_tabbar.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class FiltersSheet extends HookWidget {
//   final QueryHookResult<Object?> usersResult;
//   final QueryHookResult<Object?> circlesResult;
//   final QueryHookResult<Object?> questionsResult;

//   const FiltersSheet(this.usersResult, this.circlesResult, this.questionsResult,
//       {super.key});

//   @override
//   Widget build(BuildContext context) {
//     final MapScreenController mapScreenController = Get.find();
//     final usersTabController = useTabController(initialLength: 2);
//     final circlesTabController = useTabController(initialLength: 3);
//     final questionsTabController = useTabController(initialLength: 2);

//     final List<User> users = usersResult.result.data!['getNearByUsers']
//         .map<User>(
//           (user) => User.fromRawJson(json.encode(user)),
//         )
//         .toList() as List<User>;

//     final List<circle_model.Circle> circles =
//         circlesResult.result.data!['getNearbyCircles']
//             .map<circle_model.Circle>(
//               (circle) => circle_model.Circle.fromRawJson(json.encode(circle)),
//             )
//             .toList() as List<circle_model.Circle>;

//     final List<Question> questions =
//         questionsResult.result.data!['getQuestions']
//             .map<Question>(
//               (question) => Question.fromRawJson(json.encode(question)),
//             )
//             .toList() as List<Question>;

//     double calculateDistance(double x2, double y2) {
//       final currentUserLatitude = currentUser.value.location!.coordinates![0];
//       final currentUserLongtitude = currentUser.value.location!.coordinates![1];
//       return getDistance(currentUserLatitude, currentUserLongtitude, x2, y2);
//     }

//     void handleApplyFilters() {
//       // Apply filters on data above
//       usersResult.result.
//     }

//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         Container(
//           height: Get.height * 0.75,
//           width: Get.width,
//           decoration: BoxDecoration(
//             color: context.theme.scaffoldBackgroundColor,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   Center(
//                     child: Container(
//                       height: 5.sp,
//                       width: 70.sp,
//                       margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
//                       decoration: BoxDecoration(
//                         color: context
//                             .theme.bottomNavigationBarTheme.backgroundColor,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 15.sp),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Filter By',
//                           style: context.theme.textTheme.titleSmall,
//                         ),
//                         InkWell(
//                           onTap: () => Navigator.pop(context),
//                           child: DecoratedBox(
//                             decoration: BoxDecoration(
//                               color: context.theme.bottomNavigationBarTheme
//                                   .backgroundColor,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Padding(
//                               padding: EdgeInsets.all(4.0),
//                               child: Icon(FlutterRemix.close_fill),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               buildUsersFilter(context, usersTabController),
//               buildCirclesFilter(context, circlesTabController),
//               buildQuestionsFilter(context, questionsTabController),
//               buildRadiusFilter(context, mapScreenController.radius),
//             ],
//           ),
//         ),
//         Container(
//           height: 90.sp,
//           width: Get.width,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             boxShadow: [BoxShadow()],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               CustomButton(
//                 height: 45.sp,
//                 width: Get.width * 0.2,
//                 text: 'Clear',
//                 color: Colors.red[300]!,
//                 onPressed: () {},
//               ),
//               CustomButton(
//                 height: 45.sp,
//                 width: Get.width * 0.5,
//                 text: 'Apply',
//                 color: AppColors.primaryYellow,
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Column buildUsersFilter(BuildContext context, TabController tabController) {
//     return Column(
//       children: [
//         SizedBox(height: 30.h),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Users',
//                 style: context.theme.textTheme.labelMedium,
//               ),
//               SizedBox(height: 10.h),
//               SizedBox(
//                 height: 35.h,
//                 width: Get.width,
//                 child: CustomTabbar(
//                   controller: tabController,
//                   tabs: const [
//                     Text('Premium'),
//                     Text('Free'),
//                   ],
//                   onTap: (int val) {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Column buildCirclesFilter(BuildContext context, TabController tabController) {
//     return Column(
//       children: [
//         SizedBox(height: 30.h),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Circles',
//                 style: context.theme.textTheme.labelMedium,
//               ),
//               SizedBox(height: 10.h),
//               SizedBox(
//                 height: 35.h,
//                 width: Get.width,
//                 child: CustomTabbar(
//                   controller: tabController,
//                   tabs: const [
//                     Text('Public'),
//                     Text('Private'),
//                     Text('Joined'),
//                   ],
//                   onTap: (int val) {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Column buildQuestionsFilter(
//       BuildContext context, TabController tabController) {
//     return Column(
//       children: [
//         SizedBox(height: 30.h),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Questions',
//                 style: context.theme.textTheme.labelMedium,
//               ),
//               SizedBox(height: 10.h),
//               SizedBox(
//                 height: 35.h,
//                 width: Get.width,
//                 child: CustomTabbar(
//                   controller: tabController,
//                   tabs: const [
//                     Text('Newest'),
//                     Text('Active'),
//                   ],
//                   onTap: (int val) {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Column buildRadiusFilter(BuildContext context, RxDouble radius) {
//     return Column(
//       children: [
//         SizedBox(height: 30.sp),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.sp),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Radius',
//                 style: context.theme.textTheme.labelMedium,
//               ),
//               Obx(
//                 () => Text(
//                   '${radius.value.toStringAsFixed(0)} KMs',
//                   style: context.theme.textTheme.labelSmall,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 10.h),
//         SizedBox(
//           width: Get.width,
//           child: SliderTheme(
//             data: SliderTheme.of(context).copyWith(
//               trackHeight: 5,
//               inactiveTrackColor:
//                   context.theme.bottomNavigationBarTheme.backgroundColor,
//             ),
//             child: Obx(
//               () => Slider(
//                 value: radius.value,
//                 min: 5,
//                 max: currentUser.value.isPremium! ? 600 : 300,
//                 thumbColor: context.theme.iconTheme.color!,
//                 activeColor: AppColors.primaryYellow,
//                 onChanged: (val) {
//                   radius.value = val;
//                   // final distance = Geolocator.(controller.rootController.mapBounds.value.northEast, controller.rootController.mapBounds.value.south);
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
