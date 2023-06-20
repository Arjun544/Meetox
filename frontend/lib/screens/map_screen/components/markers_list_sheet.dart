import 'dart:convert';

import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/models/question_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/circles_screen/components/circle_tile.dart';
import 'package:frontend/widgets/close_button.dart';
import 'package:frontend/widgets/loaders/circles_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../core/imports/core_imports.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_error_widget.dart';
import '../../../widgets/show_custom_sheet.dart';
import '../../questions_screen/components/question_tile.dart';
import 'circle_details_sheet.dart';
import 'question_details_sheet.dart';
import 'user_details_sheet.dart';

class MarkersListSheet extends HookWidget {
  final QueryHookResult<Object?> usersResult;
  final QueryHookResult<Object?> circlesResult;
  final QueryHookResult<Object?> followerssResult;
  final QueryHookResult<Object?> questionsResult;

  const MarkersListSheet(this.usersResult, this.circlesResult,
      this.followerssResult, this.questionsResult,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final MapScreenController mapScreenController = Get.find();

    final currentChoice = useState(
      mapScreenController.currentMainFilter.value == 'All'
          ? 'Circles'
          : mapScreenController.currentMainFilter.value,
    );

    return Container(
      height: Get.height * 0.95,
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  decoration: BoxDecoration(
                    color: context.theme.indicatorColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: DropdownButton<String>(
                    value: currentChoice.value == 'All'
                        ? 'Circles'
                        : currentChoice.value,
                    underline: const SizedBox.shrink(),
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(14),
                    elevation: 0,
                    dropdownColor: context.theme.indicatorColor,
                    onChanged: (newValue) => currentChoice.value = newValue!,
                    items: <String>[
                      'Circles',
                      'Questions',
                      'Followers',
                      'Users'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: context.theme.textTheme.labelMedium,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              CustomCloseButton(onTap: () => Navigator.of(context).pop()),
            ],
          ),
          SizedBox(height: 30.h),
          if (currentChoice.value == 'Circles')
            usersResult.result.isLoading
                ? const CirclesLoader()
                : (circlesResult.result.data!['getNearByCircles']
                            .map<circle_model.Circle>(
                              (circle) => circle_model.Circle.fromRawJson(
                                  json.encode(circle)),
                            )
                            .toList() as List<circle_model.Circle>)
                        .isEmpty
                    ? Center(
                        heightFactor: 3.h,
                        child: CustomErrorWidget(
                          isWarining: true,
                          image: AssetsManager.sadState,
                          text: 'No circles',
                          onPressed: () => {},
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            (circlesResult.result.data!['getNearByCircles']
                                    .map<circle_model.Circle>(
                                      (circle) =>
                                          circle_model.Circle.fromRawJson(
                                              json.encode(circle)),
                                    )
                                    .toList() as List<circle_model.Circle>)
                                .length,
                        itemBuilder: (context, index) {
                          final circle_model.Circle circle = (circlesResult
                              .result.data!['getNearByCircles']
                              .map<circle_model.Circle>(
                                (circle) => circle_model.Circle.fromRawJson(
                                    json.encode(circle)),
                              )
                              .toList() as List<circle_model.Circle>)[index];
                          return CircleTile(
                            circle: circle,
                            isShowingOnMap: true,
                            onTap: () => showCustomSheet(
                              context: context,
                              child: CircleDetailsSheet(
                                circle,
                                circle_model.Circle().obs,
                              ),
                            ),
                          );
                        })
          else if (currentChoice.value == 'Questions')
            questionsResult.result.isLoading
                ? const CirclesLoader()
                : (questionsResult.result.data!['getNearByQuestions']
                            .map<Question>(
                              (question) =>
                                  Question.fromRawJson(json.encode(question)),
                            )
                            .toList() as List<Question>)
                        .isEmpty
                    ? Center(
                        heightFactor: 3.h,
                        child: CustomErrorWidget(
                          isWarining: true,
                          image: AssetsManager.sadState,
                          text: 'No questions',
                          onPressed: () => {},
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            (questionsResult.result.data!['getNearByQuestions']
                                    .map<Question>(
                                      (question) => Question.fromRawJson(
                                          json.encode(question)),
                                    )
                                    .toList() as List<Question>)
                                .length,
                        itemBuilder: (context, index) {
                          final Question question = (questionsResult
                              .result.data!['getNearByQuestions']
                              .map<Question>(
                                (question) =>
                                    Question.fromRawJson(json.encode(question)),
                              )
                              .toList() as List<Question>)[index];
                          return QuestionTile(
                            question: question,
                            onTap: () => showCustomSheet(
                              context: context,
                              child: QuestionDetailsSheet(
                                question,
                                Question().obs,
                              ),
                            ),
                          );
                        })
          else if (currentChoice.value == 'Followers')
            (followerssResult.result.data!['nearByFollowers']
                        .map<User>(
                          (follower) => User.fromRawJson(json.encode(follower)),
                        )
                        .toList() as List<User>)
                    .isEmpty
                ? CustomErrorWidget(
                    isWarining: true,
                    image: AssetsManager.sadState,
                    text: 'No followers',
                    onPressed: () => {},
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: (followerssResult.result.data!['nearByFollowers']
                            .map<User>(
                              (follower) =>
                                  User.fromRawJson(json.encode(follower)),
                            )
                            .toList() as List<User>)
                        .length,
                    itemBuilder: (context, index) {
                      final User follower =
                          (followerssResult.result.data!['nearByFollowers']
                              .map<User>(
                                (follower) =>
                                    User.fromRawJson(json.encode(follower)),
                              )
                              .toList() as List<User>)[index];
                      return GestureDetector(
                        onTap: () => showCustomSheet(
                          context: context,
                          child: UserDetailsSheet(
                            follower,
                            User().obs,
                          ),
                        ),
                        child: Container(
                          width: Get.width,
                          height: 60.sp,
                          margin: const EdgeInsets.only(bottom: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.theme.dividerColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              foregroundImage: CachedNetworkImageProvider(
                                follower.displayPic!.profile == ''
                                    ? profilePlaceHolder
                                    : follower.displayPic!.profile!,
                              ),
                            ),
                            title: Text(
                              follower.name == ''
                                  ? 'Unknown'
                                  : follower.name!.capitalizeFirst!,
                              style: context.theme.textTheme.labelSmall,
                            ),
                          ),
                        ),
                      );
                    })
          else if (currentChoice.value == 'Users')
            usersResult.result.isLoading
                ? const CirclesLoader()
                : (usersResult.result.data!['getNearByUsers']
                            .map<User>(
                              (user) => User.fromRawJson(json.encode(user)),
                            )
                            .toList() as List<User>)
                        .isEmpty
                    ? Center(
                        heightFactor: 3.h,
                        child: CustomErrorWidget(
                          isWarining: true,
                          image: AssetsManager.sadState,
                          text: 'No users',
                          onPressed: () => {},
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: (usersResult.result.data!['getNearByUsers']
                                .map<User>(
                                  (user) => User.fromRawJson(json.encode(user)),
                                )
                                .toList() as List<User>)
                            .length,
                        itemBuilder: (context, index) {
                          final User user =
                              (usersResult.result.data!['getNearByUsers']
                                  .map<User>(
                                    (user) =>
                                        User.fromRawJson(json.encode(user)),
                                  )
                                  .toList() as List<User>)[index];
                          return GestureDetector(
                            onTap: () => showCustomSheet(
                              context: context,
                              child: UserDetailsSheet(
                                user,
                                User().obs,
                              ),
                            ),
                            child: Container(
                              width: Get.width,
                              height: 60.sp,
                              margin: const EdgeInsets.only(bottom: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.theme.indicatorColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  foregroundImage: CachedNetworkImageProvider(
                                    user.displayPic!.profile == ''
                                        ? profilePlaceHolder
                                        : user.displayPic!.profile!,
                                  ),
                                ),
                                title: Text(
                                  user.name == ''
                                      ? 'Unknown'
                                      : user.name!.capitalizeFirst!,
                                  style: context.theme.textTheme.labelSmall,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
        ],
      ),
    );
  }
}
