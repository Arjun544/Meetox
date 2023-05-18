// // ignore_for_file: invalid_use_of_protected_member, iterable_contains_unrelated_type

// import 'dart:developer';

// import 'package:fl_query/fl_query.dart';
// import 'package:meetox/controllers/controller_imports.dart';
// import 'package:meetox/controllers/map_controller.dart';
// import 'package:meetox/core/imports/core_imports.dart';
// import 'package:meetox/core/imports/packages_imports.dart';
// import 'package:meetox/helpers/get_distance.dart';
// import 'package:meetox/models/circle_model.dart' as circle_model;
// import 'package:meetox/models/interest_model.dart';
// import 'package:meetox/models/question_model.dart';
// import 'package:meetox/models/user_model.dart';
// import 'package:meetox/utils/caching_keys.dart';
// import 'package:meetox/widgets/widgets_imports.dart.dart';

// class FiltersSheet extends HookWidget {
//   const FiltersSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final GlobalController globalController = Get.find();
//     final MapScreenController mapScreenController = Get.find();
//     final tabController = useTabController(initialLength: 2);

//     final nearByCirclesQuery = QueryBowl.of(context)
//         .getQuery<List<circle_model.Circle>, Map<dynamic, dynamic>>(
//             CachingKeys.nearByCirclesKey);
//     final nearByQuestionsQuery = QueryBowl.of(context)
//         .getQuery<List<Question>, Map<dynamic, dynamic>>(
//             CachingKeys.nearByQuestionsKey);
//     final nearByUsersQuery = QueryBowl.of(context)
//         .getQuery<List<UserModel>, Map<dynamic, dynamic>>(
//             CachingKeys.nearByUsersKey);

//     double calculateDistance(double x2, double y2) {
//       final currentUserLatitude = currentUser.value.location!.coordinates![0];
//       final currentUserLongtitude = currentUser.value.location!.coordinates![1];
//       return getDistance(currentUserLatitude, currentUserLongtitude, x2, y2);
//     }

//     void onApply() {
//       final bool isFunProfile =
//           mapScreenController.rootController.currentProfile.value ==
//                   ProfileType.Fun
//               ? true
//               : false;
//       if (mapScreenController.markersFilter.value == 0 &&
//           mapScreenController.radius.value == 300 &&
//           (isFunProfile
//               ? mapScreenController.selectedFunInterests.isEmpty
//               : mapScreenController.selectedProfessionFields.isEmpty)) {
//         log('firsssst condition');
//         nearByCirclesQuery!
//             .setQueryData((oldData) => mapScreenController.oldCircles.value);
//         nearByQuestionsQuery!
//             .setQueryData((oldData) => mapScreenController.oldQuestions.value);
//         nearByUsersQuery!
//             .setQueryData((oldData) => mapScreenController.oldUsers.value);
//         mapScreenController.hasAppliedFilters.value = false;
//       } else if (mapScreenController.markersFilter.value == 1 &&
//           mapScreenController.radius.value == 300 &&
//           (isFunProfile
//               ? mapScreenController.selectedFunInterests.isEmpty
//               : mapScreenController.selectedProfessionFields.isEmpty)) {
//         log('seconnd condition');

//         mapScreenController.oldCircles.value = nearByCirclesQuery!.data!;
//         mapScreenController.oldQuestions.value = nearByQuestionsQuery!.data!;
//         mapScreenController.oldUsers.value = nearByUsersQuery!.data!;

//         nearByCirclesQuery.setQueryData((oldData) => oldData!
//             .where((circle) => circle.admin == currentUser.value.id)
//             .toList());
//         nearByQuestionsQuery.setQueryData((oldData) => oldData!
//             .where((question) => question.owner == currentUser.value.id)
//             .toList());
//         nearByUsersQuery.setQueryData((oldData) =>
//             oldData!.where((user) => user.id == currentUser.value.id).toList());
//         mapScreenController.hasAppliedFilters.value = true;
//       } else if (mapScreenController.radius.value < 300 &&
//           mapScreenController.markersFilter.value == 0 &&
//           (isFunProfile
//               ? mapScreenController.selectedFunInterests.isEmpty
//               : mapScreenController.selectedProfessionFields.isEmpty)) {
//         log('third condition');

//         if (mapScreenController.oldCircles.value.isEmpty &&
//             mapScreenController.oldQuestions.isEmpty &&
//             mapScreenController.oldUsers.value.isEmpty) {
//           mapScreenController.oldCircles.value = nearByCirclesQuery!.data!;
//           mapScreenController.oldQuestions.value = nearByQuestionsQuery!.data!;
//           mapScreenController.oldUsers.value = nearByUsersQuery!.data!;
//         }

//         nearByCirclesQuery!.setQueryData((oldData) => oldData!
//             .where((circleOne) =>
//                 calculateDistance(circleOne.location.coordinates[0],
//                     circleOne.location.coordinates[1]) <=
//                 mapScreenController.radius.value)
//             .toList()
//             .where((circleTwo) => circleTwo.interests.contains(isFunProfile
//                 ? currentUser.value.funProfile.interests
//                 : currentUser.value.professionProfile.interests))
//             .toList());
//         nearByQuestionsQuery!.setQueryData((oldData) => oldData!
//             .where((questionOne) =>
//                 calculateDistance(questionOne.location.coordinates[0],
//                     questionOne.location.coordinates[1]) <=
//                 mapScreenController.radius.value)
//             .toList()
//             .where((questionTwo) => questionTwo.interests.contains(isFunProfile
//                 ? currentUser.value.funProfile.interests
//                 : currentUser.value.professionProfile.interests))
//             .toList());
//         nearByUsersQuery!.setQueryData((oldData) => oldData!
//             .where((userOne) =>
//                 calculateDistance(userOne.location.coordinates[0],
//                     userOne.location.coordinates[1]) <=
//                 mapScreenController.radius.value)
//             .toList()
//             .where((userTwo) => isFunProfile
//                 ? userTwo.funProfile.interests!
//                     .contains(currentUser.value.funProfile.interests)
//                 : userTwo.funProfile.interests!
//                     .contains(currentUser.value.professionProfile.interests))
//             .toList());
//         mapScreenController.hasAppliedFilters.value = true;
//         log('filters circles: ${nearByCirclesQuery.data!.length}');
//         log('filters questions: ${nearByQuestionsQuery.data!.length}');
//         log('filters users: ${nearByUsersQuery.data!.length}');
//       } else if (mapScreenController.radius.value < 300 &&
//           mapScreenController.markersFilter.value == 1 &&
//           (isFunProfile
//               ? mapScreenController.selectedFunInterests.isNotEmpty
//               : mapScreenController.selectedProfessionFields.isNotEmpty)) {
//         log('fouth condition');

//         if (mapScreenController.oldCircles.value.isEmpty &&
//             mapScreenController.oldQuestions.isEmpty &&
//             mapScreenController.oldCircles.value.isEmpty) {
//           mapScreenController.oldCircles.value = nearByCirclesQuery!.data!;
//           mapScreenController.oldQuestions.value = nearByQuestionsQuery!.data!;
//           mapScreenController.oldUsers.value = nearByUsersQuery!.data!;
//         }

//         nearByCirclesQuery!.setQueryData((oldData) => oldData!
//             .where((circleOne) => circleOne.admin == currentUser.value.id)
//             .toList()
//             .where((circleTwo) =>
//                 calculateDistance(circleTwo.location.coordinates[0],
//                     circleTwo.location.coordinates[1]) <=
//                 mapScreenController.radius.value)
//             .toList()
//             .where((circleThree) => circleThree.interests.contains(isFunProfile
//                 ? currentUser.value.funProfile.interests
//                 : currentUser.value.professionProfile.interests))
//             .toList());
//         nearByQuestionsQuery!.setQueryData((oldData) => oldData!
//             .where((questionOne) => questionOne.owner == currentUser.value.id)
//             .toList()
//             .where((questionTwo) =>
//                 calculateDistance(questionTwo.location.coordinates[0],
//                     questionTwo.location.coordinates[1]) <=
//                 mapScreenController.radius.value)
//             .toList()
//             .where((questionThree) => questionThree.interests.contains(
//                 isFunProfile
//                     ? currentUser.value.funProfile.interests
//                     : currentUser.value.professionProfile.interests))
//             .toList());
//         nearByUsersQuery!.setQueryData((oldData) => oldData!
//             .where((userOne) => userOne.id == currentUser.value.id)
//             .toList()
//             .where((userTwo) =>
//                 calculateDistance(userTwo.location.coordinates[0],
//                     userTwo.location.coordinates[1]) <=
//                 mapScreenController.radius.value)
//             .toList()
//             .where((userThree) => isFunProfile
//                 ? userThree.funProfile.interests!
//                     .contains(currentUser.value.funProfile.interests)
//                 : userThree.funProfile.interests!
//                     .contains(currentUser.value.professionProfile.interests))
//             .toList());
//         mapScreenController.hasAppliedFilters.value = true;
//         log('filters circles: ${nearByCirclesQuery.data!.where((circle) => calculateDistance(circle.location.coordinates[0], circle.location.coordinates[1]) <= mapScreenController.radius.value).toList().length}');
//         log('filters questions: ${nearByQuestionsQuery.data!.length}');
//         log('filters users: ${nearByUsersQuery.data!.length}');
//         log('radius.value: ${mapScreenController.radius.value}');
//       } else if (mapScreenController.markersFilter.value == 0 &&
//           mapScreenController.radius.value == 300 &&
//           (isFunProfile
//               ? mapScreenController.selectedFunInterests.isNotEmpty
//               : mapScreenController.selectedProfessionFields.isNotEmpty)) {
//         log('fifth condition');

//         mapScreenController.oldCircles.value = nearByCirclesQuery!.data!;
//         mapScreenController.oldQuestions.value = nearByQuestionsQuery!.data!;
//         mapScreenController.oldUsers.value = nearByUsersQuery!.data!;

//         log('interests: ${currentUser.value.funProfile.interests!.contains(mapScreenController.selectedFunInterests.value)}');

//         // nearByCirclesQuery.setQueryData((oldData) => oldData!
//         //     .map((e) => e.interests
//         //         .map((f) =>
//         //             mapScreenController.selectedFunInterests.value.contains(f))
//         //         .toList())
//         //     .toList());

//         nearByQuestionsQuery.setQueryData((oldData) => oldData!
//             .where((question) => isFunProfile
//                 ? question.interests
//                     .contains(mapScreenController.selectedFunInterests.value)
//                 : question.interests.contains(
//                     mapScreenController.selectedProfessionFields.value))
//             .toList());

//         // log('fun profile : ${nearByUsersQuery.data![0].funProfile.id}');
//         nearByUsersQuery.setQueryData((oldData) {
//           return oldData!.where((user) {
//             if (isFunProfile && user.funProfile.id != null) {
//               return user.funProfile.interests!
//                   .contains(mapScreenController.selectedFunInterests.value);
//             } else if (!isFunProfile && user.professionProfile.id != null) {
//               return user.professionProfile.interests!
//                   .contains(mapScreenController.selectedProfessionFields.value);
//             } else {
//               return false;
//             }
//           }).toList();
//         });
//         // nearByUsersQuery.setQueryData((oldData) => oldData!
//         //     .where((user) => (isFunProfile &&
//         //             (isFunProfile
//         //                 ? user.funProfile.id != null
//         //                 : user.professionProfile.id != null))

//         //         : user.professionProfile.interests!
//         //             .contains(currentUser.value.professionProfile.interests))
//         //     .toList());
//         log('filters circles: ${nearByCirclesQuery.data!.length}');
//         log('filters questions: ${nearByQuestionsQuery.data!.length}');
//         log('filters users: ${nearByUsersQuery.data!.length}');
//         mapScreenController.hasAppliedFilters.value = true;
//       }
//       Get.back();
//       showToast('Filters applied');
//     }

//     void onClear() {
//       if (mapScreenController.oldCircles.value.isNotEmpty ||
//           mapScreenController.oldQuestions.value.isNotEmpty ||
//           mapScreenController.oldUsers.value.isNotEmpty) {
//         nearByCirclesQuery!
//             .setQueryData((oldData) => mapScreenController.oldCircles.value);
//         nearByQuestionsQuery!
//             .setQueryData((oldData) => mapScreenController.oldQuestions.value);
//         nearByUsersQuery!
//             .setQueryData((oldData) => mapScreenController.oldUsers.value);
//       }
//       mapScreenController.hasAppliedFilters.value = false;
//       mapScreenController.markersFilter.value = 0;
//       mapScreenController.radius.value =
//           currentUser.value.isPremium ? 600 : 300;
//       mapScreenController.selectedFunInterests.value = [];
//       mapScreenController.selectedProfessionFields.value = [];

//       Get.back();
//       showToast('Filters cleared');
//     }

//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         Container(
//           height: Get.height * 0.95,
//           width: Get.width,
//           decoration: BoxDecoration(
//             color: context.theme.scaffoldBackgroundColor,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
//                           style: context.theme.textTheme.headline3,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Get.back();
//                           },
//                           child: DecoratedBox(
//                             decoration: BoxDecoration(
//                               color: context.theme.backgroundColor,
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
//               buildMarkersFilter(
//                   context, tabController, mapScreenController.markersFilter),
//               buildRadiusFilter(context, mapScreenController.radius),
//               buildInterestsFilter(
//                   context, mapScreenController, globalController),
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
//                 onPressed: onClear,
//               ),
//               CustomButton(
//                 height: 45.sp,
//                 width: Get.width * 0.5,
//                 text: 'Apply',
//                 color: AppColors.primaryYellow,
//                 onPressed: onApply,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Column buildMarkersFilter(BuildContext context, TabController tabController,
//       RxInt currentMarkerValue) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 30.sp),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.sp),
//           child: Text(
//             'Markers',
//             style: context.theme.textTheme.headline5,
//           ),
//         ),
//         Container(
//           width: Get.width,
//           height: 40.sp,
//           margin: EdgeInsets.fromLTRB(15.sp, 10.sp, 15.sp, 0),
//           decoration: BoxDecoration(
//             color: context.isDarkMode ? Colors.black : AppColors.customGrey,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: TabBar(
//             controller: tabController,
//             indicatorColor: Colors.green,
//             onTap: (val) => currentMarkerValue.value = val,
//             tabs: const [
//               Tab(
//                 text: 'All',
//               ),
//               Tab(
//                 text: 'Only Yours',
//               ),
//             ],
//             labelStyle:
//                 context.theme.textTheme.headline6!.copyWith(letterSpacing: 1),
//             unselectedLabelStyle:
//                 context.theme.textTheme.headline6!.copyWith(letterSpacing: 1),
//             labelColor: context.theme.textTheme.headline5!.color,
//             indicator: RectangularIndicator(
//               color: AppColors.primaryYellow,
//               bottomLeftRadius: 12,
//               bottomRightRadius: 12,
//               topLeftRadius: 12,
//               topRightRadius: 12,
//               verticalPadding: 4,
//               horizontalPadding: 4,
//               paintingStyle: PaintingStyle.fill,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// Column buildRadiusFilter(BuildContext context, RxDouble radius) {
//   return Column(
//     children: [
//       SizedBox(height: 30.sp),
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15.sp),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Radius',
//               style: context.theme.textTheme.headline5,
//             ),
//             Obx(
//               () => Text(
//                 '${radius.value.toStringAsFixed(0)} KMs',
//                 style: context.theme.textTheme.headline6,
//               ),
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 10.sp),
//       SizedBox(
//         width: Get.width,
//         child: SliderTheme(
//           data: SliderTheme.of(context).copyWith(
//             trackHeight: 5,
//             inactiveTrackColor: context.theme.backgroundColor,
//           ),
//           child: Obx(
//             () => Slider(
//               value: radius.value,
//               min: 5,
//               max: currentUser.value.isPremium ? 600 : 300,
//               thumbColor: context.theme.iconTheme.color!,
//               activeColor: AppColors.primaryYellow,
//               onChanged: (val) {
//                 radius.value = val;
//                 // final distance = Geolocator.(controller.rootController.mapBounds.value.northEast, controller.rootController.mapBounds.value.south);
//               },
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Column buildInterestsFilter(
//     BuildContext context,
//     MapScreenController mapScreenController,
//     GlobalController globalController) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(height: 20.sp),
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15.sp),
//         child: Text(
//           'Interests',
//           style: context.theme.textTheme.headline5,
//         ),
//       ),
//       SizedBox(
//         height: Get.height * 0.55,
//         width: Get.width,
//         child: Obx(
//           () => MasonryGridView.count(
//             itemCount:
//                 mapScreenController.rootController.currentProfile.value ==
//                         ProfileType.Fun
//                     ? globalController.interests.length
//                     : globalController.professionFields.length,
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             crossAxisCount: 5,
//             mainAxisSpacing: 16.sp,
//             padding: EdgeInsets.only(right: 15.sp, left: 15.sp, bottom: 100.sp),
//             itemBuilder: ((context, index) {
//               final InterestModel interest =
//                   mapScreenController.rootController.currentProfile.value ==
//                           ProfileType.Fun
//                       ? globalController.interests[index]
//                       : globalController.professionFields[index];
//               return Theme(
//                 data: ThemeData(canvasColor: Colors.transparent),
//                 child: GestureDetector(
//                   onTap:
//                       mapScreenController.rootController.currentProfile.value ==
//                               ProfileType.Fun
//                           ? () {
//                               if (mapScreenController.selectedFunInterests
//                                   .contains(interest)) {
//                                 mapScreenController.selectedFunInterests
//                                     .remove(interest);
//                               } else {
//                                 mapScreenController.selectedFunInterests
//                                     .add(interest);
//                               }
//                             }
//                           : () {
//                               if (mapScreenController.selectedProfessionFields
//                                   .contains(interest)) {
//                                 mapScreenController.selectedProfessionFields
//                                     .remove(interest);
//                               } else {
//                                 mapScreenController.selectedProfessionFields
//                                     .add(interest);
//                               }
//                             },
//                   child: Obx(
//                     () => Chip(
//                       backgroundColor: mapScreenController
//                                   .rootController.currentProfile.value ==
//                               ProfileType.Fun
//                           ? mapScreenController.selectedFunInterests
//                                   .contains(interest)
//                               ? AppColors.primaryYellow
//                               : context.isDarkMode
//                                   ? Colors.black
//                                   : AppColors.customGrey
//                           : mapScreenController.selectedProfessionFields
//                                   .contains(interest)
//                               ? AppColors.primaryYellow
//                               : context.isDarkMode
//                                   ? Colors.black
//                                   : AppColors.customGrey,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(
//                           color: context.isDarkMode
//                               ? Colors.black
//                               : AppColors.customGrey,
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       avatar: Icon(
//                         interest.icon,
//                         color: context.theme.appBarTheme.iconTheme!.color,
//                         size: 18.sp,
//                       ),
//                       label: Text(
//                         interest.title,
//                         style: context.theme.textTheme.headline6,
//                       ),
//                       labelPadding: EdgeInsets.only(left: 10.sp),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 30.sp,
//                         vertical: 14.sp,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     ],
//   );
// }
