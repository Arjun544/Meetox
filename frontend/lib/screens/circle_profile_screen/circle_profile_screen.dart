import 'package:frontend/controllers/circle_profile_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/user/queries.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/models/user_model.dart';
import 'package:frontend/widgets/mini_map.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'components/circle_details.dart';

class CircleProfileScreen extends HookWidget {
  final circle_model.Circle circle;
  final ValueNotifier<int> allMembers;

  const CircleProfileScreen(
      {super.key, required this.circle, required this.allMembers});

  @override
  Widget build(BuildContext context) {
    Get.put(CircleProfileController());
    final adminResult = useQuery(
      QueryOptions(
        document: gql(getUser),
        parserFn: (data) => User.fromJson(data['getUser']),
        variables: {
          'id': circle.admin!,
        },
      ),
    );
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CircleDetails(circle, allMembers),
          ];
        },
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 200.h,
                  width: Get.width,
                  child: MiniMap(
                    latitude: circle.location!.coordinates![0],
                    longitude: circle.location!.coordinates![1],
                  ),
                ),
              ),
              Column(
                children: [
                  adminResult.result.isLoading
                      ? const SizedBox.shrink()
                      : Text(
                          'Created by ${circle.admin == currentUser.value.id ? 'YOU' : adminResult.result.parsedData!.name!.capitalizeFirst!} ${timeago.format(
                            circle.createdAt!,
                            locale: 'en',
                            allowFromNow: true,
                          )}',
                          style: context.theme.textTheme.labelSmall!.copyWith(
                            color: context.theme.textTheme.labelSmall!.color!
                                .withOpacity(0.5),
                            letterSpacing: 1,
                          ),
                        ),
                  SizedBox(height: 20.h),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: context.theme.indicatorColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'www.meetox.com/${circle.name}',
                        style: context.theme.textTheme.labelSmall,
                      ),
                    ),
                    trailing: const Icon(IconsaxBold.copy),
                    splashColor: Colors.transparent,
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: 'www.meetox.com/${circle.name}'));
                      showToast('Copied profile link');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
