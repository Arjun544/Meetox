// import 'package:fl_query/fl_query.dart';
// import 'package:meetox/controllers/map_controller.dart';
// import 'package:meetox/core/imports/packages_imports.dart';
// import 'package:meetox/models/circle_model.dart' as circle_model;
// import 'package:meetox/models/question_model.dart';
// import 'package:meetox/models/user_model.dart';
// import 'package:meetox/screens/add_circle_screen/components/circle_details.dart';
// import 'package:meetox/screens/circles_screen/components/circle_tile.dart';
// import 'package:meetox/screens/map_screen/components/circle_details_sheet.dart';
// import 'package:meetox/screens/map_screen/components/question_details_sheet.dart';
// import 'package:meetox/widgets/close_button.dart';

// import '../../../core/imports/core_imports.dart';
// import '../../../utils/caching_keys.dart';
// import '../../../utils/constants.dart';
// import '../../../widgets/custom_error_widget.dart';
// import '../../../widgets/show_custom_sheet.dart';
// import '../../questions_screen/components/question_tile.dart';
// import 'user_details_sheet.dart';

// class MarkersListSheet extends HookWidget {
//   MarkersListSheet();
//   @override
//   Widget build(BuildContext context) {
//     final MapScreenController mapScreenController = Get.find();

//     final currentChoice = useState(
//       mapScreenController.currentMainFilter.value == 'All'
//           ? 'Circles'
//           : mapScreenController.currentMainFilter.value,
//     );

//     final Query<List<circle_model.Circle>, dynamic>? circles =
//         QueryBowl.of(context).getQuery(CachingKeys.nearByCirclesKey);
//     final Query<List<QuestionModel>, dynamic>? questions =
//         QueryBowl.of(context).getQuery(CachingKeys.nearByQuestionsKey);
//     final Query<List<UserModel>, dynamic>? followers =
//         QueryBowl.of(context).getQuery(CachingKeys.neayByFollowersKey);
//     final Query<List<UserModel>, dynamic>? users =
//         QueryBowl.of(context).getQuery(CachingKeys.nearByUsersKey);

//     return Container(
//       height: Get.height * 0.95,
//       width: Get.width,
//       padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
//       decoration: BoxDecoration(
//         color: context.theme.scaffoldBackgroundColor,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: context.theme.backgroundColor,
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: DropdownButton<String>(
//                     value: currentChoice.value == 'All'
//                         ? 'Circles'
//                         : currentChoice.value,
//                     underline: const SizedBox.shrink(),
//                     isExpanded: true,
//                     dropdownColor: context.theme.scaffoldBackgroundColor,
//                     onChanged: (newValue) => currentChoice.value = newValue!,
//                     items: <String>[
//                       'Circles',
//                       'Questions',
//                       'Followers',
//                       'Users'
//                     ].map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 20.sp),
//               CustomCloseButton(onTap: () => Get.back()),
//             ],
//           ),
//           SizedBox(height: 30),
//           if (currentChoice.value == 'Circles')
//             circles!.data!.isEmpty
//                 ? CustomErrorWidget(
//                     isWarining: true,
//                     image: AssetsManager.sadState,
//                     text: 'No circles',
//                     onPressed: () => {},
//                   )
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemCount: circles.data!.length,
//                     itemBuilder: (context, index) {
//                       return CircleTile(
//                         circle: circles.data![index],
//                         isShowingOnMap: true,
//                         onTap: () => showCustomSheet(
//                           context: context,
//                           child: CircleDetailsSheet(
//                             circles.data![index],
//                             ValueNotifier(false),
//                           ),
//                         ),
//                       );
//                     })
//           else if (currentChoice.value == 'Questions')
//             questions!.data!.isEmpty
//                 ? CustomErrorWidget(
//                     isWarining: true,
//                     image: AssetsManager.sadState,
//                     text: 'No question',
//                     onPressed: () => {},
//                   )
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemCount: questions.data!.length,
//                     itemBuilder: (context, index) {
//                       return QuestionTile(
//                         question: questions.data![index],
//                         onTap: () => showCustomSheet(
//                           context: context,
//                           child: QuestionDetailsSheet(
//                             questions.data![index],
//                             ValueNotifier(false),
//                           ),
//                         ),
//                       );
//                     })
//           else if (currentChoice.value == 'Followers')
//             followers!.data!.isEmpty
//                 ? CustomErrorWidget(
//                     isWarining: true,
//                     image: AssetsManager.sadState,
//                     text: 'No followers',
//                     onPressed: () => {},
//                   )
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemCount: followers.data!.length,
//                     itemBuilder: (context, index) {
//                       final follower = followers.data![index];
//                       return GestureDetector(
//                         onTap: () => showCustomSheet(
//                           context: context,
//                           child: UserDetailsSheet(
//                             followers.data![index],
//                             ValueNotifier(false),
//                           ),
//                         ),
//                         child: Container(
//                           width: Get.width,
//                           height: 60.sp,
//                           margin: EdgeInsets.only(bottom: 15),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: context.theme.backgroundColor,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               foregroundImage: CachedNetworkImageProvider(
//                                 follower.displayPic!.profile == ''
//                                     ? profilePlaceHolder
//                                     : follower.displayPic!.profile!,
//                               ),
//                             ),
//                             title: Text(
//                               follower.name == ''
//                                   ? 'Unknown'
//                                   : follower.name!.capitalize!,
//                               style: context.theme.textTheme.headline5,
//                             ),
//                           ),
//                         ),
//                       );
//                     })
//           else if (currentChoice.value == 'Users')
//             users!.data!.isEmpty
//                 ? CustomErrorWidget(
//                     isWarining: true,
//                     image: AssetsManager.sadState,
//                     text: 'No users',
//                     onPressed: () => {},
//                   )
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemCount: users.data!.length,
//                     itemBuilder: (context, index) {
//                       final user = users.data![index];
//                       return GestureDetector(
//                         onTap: () => showCustomSheet(
//                           context: context,
//                           child: UserDetailsSheet(
//                             user,
//                             ValueNotifier(false),
//                           ),
//                         ),
//                         child: Container(
//                           width: Get.width,
//                           height: 60.sp,
//                           margin: EdgeInsets.only(bottom: 15),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: context.theme.backgroundColor,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               foregroundImage: CachedNetworkImageProvider(
//                                 user.displayPic!.profile == ''
//                                     ? profilePlaceHolder
//                                     : user.displayPic!.profile!,
//                               ),
//                             ),
//                             title: Text(
//                               user.name == ''
//                                   ? 'Unknown'
//                                   : user.name!.capitalize!,
//                               style: context.theme.textTheme.headline5,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//         ],
//       ),
//     );
//   }
// }
