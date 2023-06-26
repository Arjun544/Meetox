import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/circle/mutations.dart';
import 'package:frontend/graphql/circle/queries.dart';
import 'package:frontend/helpers/get_distance.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/utils/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../circle_profile_screen/circle_profile_screen.dart';

class CircleDetailsSheet extends HookWidget {
  final circle_model.Circle circle;
  final Rx<circle_model.Circle> tappedCircle;

  const CircleDetailsSheet(this.circle, this.tappedCircle, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapScreenController>();
    final members = useState(circle.members!);

    final double currentLatitude =
        controller.rootController.currentPosition.value.latitude;
    final double currentLongitude =
        controller.rootController.currentPosition.value.longitude;
    final double circleLatitude = circle.location!.coordinates![0];
    final double circleLongitude = circle.location!.coordinates![1];

    final double distanceBtw = getDistance(
      currentLatitude,
      currentLongitude,
      circleLatitude,
      circleLongitude,
    );

    final checkIsMember = useQuery(
      QueryOptions(
        document: gql(isMember),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "id": circle.id,
        },
        onError: (data) => logError(data.toString()),
      ),
    );
    final addNewMember = useMutation(
      MutationOptions(
        document: gql(addMember),
        onCompleted: (data) {
          if (data != null && data['addMember'] != null) {
            members.value += 1;
            checkIsMember.refetch();
          }
        },
      ),
    );
    final removeMember = useMutation(
      MutationOptions(
        document: gql(leaveMember),
        onCompleted: (data) {
          if (data != null && data['leaveMember'] != null) {
            members.value -= 1;
            checkIsMember.refetch();
          }
        },
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.animatedMapMove(
        LatLng(
          circleLatitude,
          circleLongitude,
        ),
        14,
      );
    });
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            controller.isFiltersVisible.value = true;
            tappedCircle.value = circle_model.Circle();
            Navigator.pop(context);
          },
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.transparent,
          ),
        ),
        Container(
          width: Get.width,
          margin: EdgeInsets.only(top: Get.height * 0.55),
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  height: 5.sp,
                  width: 70.sp,
                  decoration: BoxDecoration(
                    color:
                        context.theme.bottomNavigationBarTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              ListTile(
                dense: true,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: circle.image!.image!.isEmpty
                        ? profilePlaceHolder
                        : circle.image!.image!,
                    // height: 170.sp,
                    width: 50.sp,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  circle.name!.capitalizeFirst!,
                  style: context.theme.textTheme.labelMedium,
                ),
                subtitle: Text(
                  circle.location!.address!.capitalizeFirst!,
                  style: context.theme.textTheme.labelSmall!.copyWith(
                    color: Colors.grey,
                  ),
                ),
                trailing: !circle.isPrivate!
                    ? InkWell(
                        onTap: () async {
                          if (checkIsMember.result.data!['isMember']) {
                            removeMember.runMutation({
                              "id": circle.id,
                            });
                          } else {
                            if (members.value == circle.limit) {
                              showToast('Circle reached members limit');
                            } else {
                              addNewMember.runMutation({
                                "id": circle.id,
                              });
                            }
                          }
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: checkIsMember.result.isLoading
                                ? AppColors.primaryYellow
                                : checkIsMember.result.data?['isMember'] ==
                                        false
                                    ? members.value == circle.limit
                                        ? context.theme.indicatorColor
                                        : AppColors.primaryYellow
                                    : checkIsMember.result.data?['isMember']
                                        ? Colors.redAccent
                                        : AppColors.primaryYellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.sp,
                              vertical: 6.sp,
                            ),
                            child: checkIsMember.result.isLoading
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                    color: AppColors.customBlack,
                                    size: 20.sp,
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        checkIsMember.result.data!['isMember']
                                            ? FlutterRemix.logout_circle_fill
                                            : FlutterRemix.login_circle_fill,
                                        size: 16.sp,
                                        color: context.theme.iconTheme.color!
                                            .withOpacity(
                                                members.value == circle.limit &&
                                                        !checkIsMember.result
                                                            .data!['isMember']
                                                    ? 0.5
                                                    : 1),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        checkIsMember.result.data!['isMember']
                                            ? 'Leave'
                                            : 'Join',
                                        style:
                                            context.theme.textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () => showToast('Circle is private'),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.theme.indicatorColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.sp, vertical: 10.sp),
                            child: Icon(
                              FlutterRemix.door_lock_fill,
                              size: 16.sp,
                              color: context.theme.iconTheme.color,
                            ),
                          ),
                        ),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        members.value.toString(),
                        style: context.theme.textTheme.labelMedium,
                      ),
                      Text(
                        'Members',
                        style: context.theme.textTheme.labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        circle.limit.toString(),
                        style: context.theme.textTheme.labelMedium,
                      ),
                      Text(
                        'Limit',
                        style: context.theme.textTheme.labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 45.sp,
                        decoration: BoxDecoration(
                          color: context.theme.indicatorColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FlutterRemix.pin_distance_fill,
                              size: 22.sp,
                              color: context.theme.iconTheme.color,
                            ),
                            Text(
                              '~ ${distanceBtw.toStringAsFixed(0)} KMs',
                              style: context.theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 45.sp,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.theme.indicatorColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          circle.isPrivate! ? 'Private' : 'Public',
                          style: context.theme.textTheme.labelSmall,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.to(
                          () => CircleProfileScreen(
                            circle: circle,
                            allMembers: members,
                          ),
                        ),
                        child: Container(
                          height: 45.sp,
                          decoration: BoxDecoration(
                            color: context.theme.indicatorColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            FlutterRemix.profile_fill,
                            size: 22.sp,
                            color: context.theme.iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.sp,
                width: Get.width,
                margin:
                    EdgeInsets.only(right: 15.sp, left: 15.sp, bottom: 15.sp),
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FlutterRemix.treasure_map_fill,
                      size: 18.sp,
                      color: context.theme.iconTheme.color,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Navigate',
                      style: context.theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
