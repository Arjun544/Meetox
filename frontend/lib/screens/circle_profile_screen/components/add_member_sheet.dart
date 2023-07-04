import 'package:frontend/controllers/circle_profile_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/close_button.dart';
import 'package:frontend/widgets/custom_tabbar.dart';

import 'followers_view.dart';
import 'followings_view.dart';

class AddMemberSheet extends HookWidget {
  final String id;
  final int limit;
  final ValueNotifier<int> members;

  const AddMemberSheet(this.id, this.members, this.limit, {super.key});

  @override
  Widget build(BuildContext context) {
    final CircleProfileController controller = Get.find();
    return Container(
      height: Get.height * 0.9,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add members ( ${members.value}/$limit )',
                style: context.theme.textTheme.labelLarge,
              ),
              CustomCloseButton(
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          CustomTabbar(
            controller: controller.tabController,
            tabs: const [
              Text('Followers'),
              Text('Following'),
            ],
            onTap: (int page) {},
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                FollowersView(
                  id,
                  members,
                ),
                FollowingView(
                  id,
                  members,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
