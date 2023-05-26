import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/online_indicator.dart';

class FollowerTile extends StatelessWidget {
  const FollowerTile({required this.follower, required this.list, super.key});
  final User follower;
  final RxList<User> list;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (list.contains(follower)) {
          list.remove(follower);
        } else {
          list.add(follower);
        }
      },
      child: Column(
        children: [
          Material(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 6.sp, horizontal: 15.sp),
              minLeadingWidth: 30.sp,
              leading: Stack(
                children: [
                  Container(
                    width: 40.sp,
                    height: 40.sp,
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          follower.displayPic!.profile == ''
                              ? profilePlaceHolder
                              : follower.displayPic!.profile!,
                        ),
                      ),
                    ),
                  ),
                  OnlineIndicator(id: follower.id!),
                ],
              ),
              title: Text(
                follower.name == ''
                    ? 'Unknown'
                    : follower.name!.capitalizeFirst!,
                style: context.theme.textTheme.labelSmall,
              ),
              trailing: Theme(
                data: ThemeData(
                  unselectedWidgetColor: context.theme.scaffoldBackgroundColor,
                ),
                child: IgnorePointer(
                  child: Obx(
                    () => Checkbox(
                      value: list.contains(follower),
                      onChanged: (val) {},
                      activeColor: AppColors.primaryYellow,
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.sp),
        ],
      ),
    );
  }
}
