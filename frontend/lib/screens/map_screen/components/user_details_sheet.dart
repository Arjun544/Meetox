// import 'dart:developer';

// import 'package:fl_query/fl_query.dart';
// import 'package:meetox/configs/socket_config.dart';
// import 'package:meetox/controllers/conversation_controller.dart';
// import 'package:meetox/controllers/followers_screen_controller.dart';
// import 'package:meetox/controllers/map_controller.dart';
// import 'package:meetox/core/imports/core_imports.dart';
// import 'package:meetox/core/imports/packages_imports.dart';
// import 'package:meetox/helpers/get_distance.dart';
// import 'package:meetox/models/conversation_model.dart';
// import 'package:meetox/models/follower_model.dart';
// import 'package:meetox/models/user_model.dart';
// import 'package:meetox/screens/chat_screen/chat_screen.dart';
// import 'package:meetox/services/conversation_services.dart';
// import 'package:meetox/utils/caching_keys.dart';
// import 'package:meetox/utils/utils_imports.dart';
// import 'package:meetox/widgets/show_custom_sheet.dart';

// import '../../../queries/followers_queries.dart';
// import '../../../widgets/online_indicator.dart';
// import '../../../widgets/show_toast.dart';
// import '../../followers_screen/followers_screen.dart';

// class UserDetailsSheet extends HookWidget {
//   final UserModel user;
//   final ValueNotifier<bool> isMarkerTapped;

//   UserDetailsSheet(this.user, this.isMarkerTapped);

//   @override
//   Widget build(BuildContext context) {
//     final MapScreenController controller = Get.find();
//     final ValueNotifier<int> followers = useState(user.followers!.length);

//     final followMutation = useMutation(job: FollowersQueries.followMutation);
//     final unfollowMutation =
//         useMutation(job: FollowersQueries.unfollowMutataion);

//     final ValueNotifier<bool> isFetchingConversations = useState(false);

//     final double currentLatitude =
//         controller.rootController.currentPosition.value.latitude;
//     final double currentLongitude =
//         controller.rootController.currentPosition.value.longitude;
//     final double userLatitude = user.location!.coordinates![0];
//     final double userLongitude = user.location!.coordinates![1];

//     final double distanceBtw = getDistance(
//       currentLatitude,
//       currentLongitude,
//       userLatitude,
//       userLongitude,
//     );

//     Future handleFollow() async {
//       await followMutation.mutateAsync({
//         'to': user.id,
//       });

//       if (followMutation.hasError) {
//         log('mutation error: ${followMutation.error}');
//         showToast('Request failed');
//         followMutation.reset();
//       } else if (followMutation.hasData) {
//         followers.value += 1;
//         currentUser.value.followings!.add(user.id!);
//       }
//     }

//     Future handleUnfollow() async {
//       await unfollowMutation.mutateAsync({
//         'to': user.id,
//       });
//       if (unfollowMutation.hasError) {
//         log('mutation error: ${unfollowMutation.error}');
//         showToast('Request failed');
//         unfollowMutation.reset();
//       } else if (unfollowMutation.hasData) {
//         followers.value -= 1;
//         currentUser.value.followings!.remove(user.id!);
//       }
//     }

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       controller.animatedMapMove(
//         LatLng(
//           userLatitude,
//           userLongitude,
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
//               SizedBox(
//                 height: 40,
//                 child: ListTile(
//                   dense: true,
//                   contentPadding: EdgeInsets.zero,
//                   horizontalTitleGap: 16,
//                   leading: Padding(
//                     padding: const EdgeInsets.only(left: 16.0),
//                     child: Stack(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 60,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: CachedNetworkImage(
//                               imageUrl: user.displayPic!.profile == ''
//                                   ? profilePlaceHolder
//                                   : user.displayPic!.profile!,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         OnlineIndicator(
//                           id: user.id!,
//                         ),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     user.name == '' ? 'Unknown' : user.name!.capitalize!,
//                     style: context.theme.textTheme.headline3,
//                   ),
//                   subtitle: Text(
//                     user.location?.address?.capitalize ?? 'Unknown',
//                     style: context.theme.textTheme.headline6!.copyWith(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   trailing: Padding(
//                     padding: const EdgeInsets.only(right: 16.0),
//                     child: Obx(
//                       () => InkWell(
//                         onTap: () async =>
//                             currentUser.value.followings!.contains(user.id)
//                                 ? await handleUnfollow()
//                                 : await handleFollow(),
//                         child: DecoratedBox(
//                           decoration: BoxDecoration(
//                             color:
//                                 currentUser.value.followings!.contains(user.id)
//                                     ? Colors.redAccent
//                                     : AppColors.primaryYellow,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 20.sp, vertical: 6.sp),
//                             child: followMutation.isLoading ||
//                                     unfollowMutation.isLoading
//                                 ? LoadingAnimationWidget.staggeredDotsWave(
//                                     color: AppColors.customBlack,
//                                     size: 20.sp,
//                                   )
//                                 : Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(
//                                         currentUser.value.followings!
//                                                 .contains(user.id)
//                                             ? FlutterRemix.user_unfollow_fill
//                                             : FlutterRemix.user_add_fill,
//                                         size: 16.sp,
//                                         color: context.theme.iconTheme.color,
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         currentUser.value.followings!
//                                                 .contains(user.id)
//                                             ? 'Unfollow'
//                                             : 'Follow',
//                                         style:
//                                             context.theme.textTheme.headline6,
//                                       ),
//                                     ],
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       final FollowersScreenController
//                           followersScreenController =
//                           Get.put(FollowersScreenController());
//                       followersScreenController.selectedUserId.value = user.id!;
//                       Get.to(() => FollowersScreen(user));
//                       followersScreenController.tabController.animateTo(0);
//                     },
//                     child: Column(
//                       children: [
//                         Text(
//                           followers.value.toString(),
//                           style: context.theme.textTheme.headline4,
//                         ),
//                         Text(
//                           'Followers',
//                           style: context.theme.textTheme.headline6!
//                               .copyWith(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       final FollowersScreenController
//                           followersScreenController =
//                           Get.put(FollowersScreenController());
//                       Get.to(() => FollowersScreen(user));
//                       followersScreenController.tabController.animateTo(1);
//                     },
//                     child: Column(
//                       children: [
//                         Text(
//                           user.followings!.length.toString(),
//                           style: context.theme.textTheme.headline4,
//                         ),
//                         Text(
//                           'followings',
//                           style: context.theme.textTheme.headline6!
//                               .copyWith(color: Colors.grey),
//                         ),
//                       ],
//                     ),
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
//                     const SizedBox(width: 20),
//                     Expanded(
//                       child: InkWell(
//                         onTap: () async {
//                           // Fetches user conversations and checks if any conversation is available with this user
//                           isFetchingConversations.value = true;
//                           final List<Conversation> conversations =
//                               await ConversationServices.getConversations();
//                           isFetchingConversations.value = false;

//                           final Conversation conversation =
//                               conversations.firstWhere(
//                                   (conversation) =>
//                                       conversation.members!.contains(user),
//                                   orElse: () => Conversation());

//                           if (isFetchingConversations.value == false &&
//                               conversation.id != null) {
//                             final ConversationController
//                                 conversationController =
//                                 Get.put(ConversationController());
//                             conversationController.currentConversationId.value =
//                                 conversation.id!;

//                             Get.to(
//                               () => ChatScreen(
//                                 user: user,
//                                 conversation: conversation,
//                               ),
//                             );
//                           } else {
//                             Get.to(
//                               () => ChatScreen(
//                                 user: user,
//                                 conversation: Conversation(type: 'private'),
//                               ),
//                             );
//                           }
//                         },
//                         child: Container(
//                           height: 45.sp,
//                           width: 50.sp,
//                           decoration: BoxDecoration(
//                             color: context.theme.backgroundColor,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: isFetchingConversations.value
//                               ? Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     LoadingAnimationWidget.staggeredDotsWave(
//                                       color: AppColors.primaryYellow,
//                                       size: 20.sp,
//                                     ),
//                                   ],
//                                 )
//                               : Icon(
//                                   FlutterRemix.chat_smile_2_fill,
//                                   size: 22.sp,
//                                   color: context.theme.iconTheme.color,
//                                 ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
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
//                     const SizedBox(width: 20),
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
