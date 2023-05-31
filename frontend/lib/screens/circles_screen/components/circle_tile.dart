import 'package:flutter/cupertino.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/utils/constants.dart';

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
    return Container(
      width: Get.width,
      height: 60.sp,
      margin: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 24.h,
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
          style: context.theme.textTheme.labelSmall!.copyWith(
            fontSize: 10.sp,
          ),
        ),
        trailing: isShowingOnMap
            ? const SizedBox.shrink()
            : InkWell(
                onTap: () => showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          foregroundImage: CachedNetworkImageProvider(
                            circle.image!.image!.isEmpty
                                ? profilePlaceHolder
                                : circle.image!.image!,
                          ),
                        ),
                        SizedBox(width: 15.sp),
                        Text(
                          circle.name == ''
                              ? 'Unknown'
                              : circle.name!.capitalizeFirst!,
                          style: context.theme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: context.theme.textTheme.labelMedium,
                      ),
                    ),
                    actions: <CupertinoActionSheetAction>[
                      CupertinoActionSheetAction(
                        onPressed: () {},
                        child: Text(
                          'View profile',
                          style: context.theme.textTheme.labelMedium,
                        ),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () {},
                        child: Text(
                          'Delete',
                          style: context.theme.textTheme.labelMedium!.copyWith(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
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
    );
  }
}
