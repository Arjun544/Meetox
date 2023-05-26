// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/screens/circles_screen/components/circle_more_options.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

class CircleTile extends HookWidget {
  const CircleTile({
    required this.circle,
    required this.onTap,
    super.key,
    this.isShowingOnMap = false,
  });
  final circle_model.Circle circle;
  final bool isShowingOnMap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 60.sp,
        margin: const EdgeInsets.only(bottom: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: CircleAvatar(
            foregroundImage: CachedNetworkImageProvider(
              circle.image!.image!.isEmpty
                  ? profilePlaceHolder
                  : circle.image!.image!,
            ),
          ),
          title: Text(
            circle.name == '' ? 'Unknown' : circle.name!.capitalizeFirst!,
            style: context.theme.textTheme.labelMedium,
          ),
          subtitle: Text(
            'Memebers: ${circle.members!.length}',
            style: context.theme.textTheme.labelSmall,
          ),
          trailing: isShowingOnMap
              ? const SizedBox.shrink()
              : InkWell(
                  onTap: () => showCustomSheet(
                    context: context,
                    child: CircleMoreOptionsSheet(
                      circle: circle,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Icon(
                      FlutterRemix.more_2_fill,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
