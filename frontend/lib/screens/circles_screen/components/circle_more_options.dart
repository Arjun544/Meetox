// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/utils/constants.dart';

class CircleMoreOptionsSheet extends HookWidget {
  const CircleMoreOptionsSheet({required this.circle, super.key});
  final circle_model.Circle circle;
  @override
  Widget build(BuildContext context) {
    final rootController = Get.find<RootController>();

    Future<void> handleRemoveCircle() async {
      // await removeCircleMutation.mutateAsync({
      //   'circleId': circle.id,
      // });

      // if (removeCircleMutation.hasError) {
      //   log('remove circle mutation error: ${removeCircleMutation.error}');
      //   showToast('Request failed');
      //   removeCircleMutation.reset();
      // } else if (removeCircleMutation.hasData) {
      //   showToast('Circle removed');

      //   // Remove this request from requests
      //   QueryBowl.of(context).setQueryData<circle_model.CircleModel, void>(
      //       CachingKeys.userCirclesKey, (oldData) {
      //     oldData!.circles!.remove(circle);
      //     return oldData;
      //   });
      //   if (rootController.circlesPagingController.itemList != null) {
      //     rootController.circlesPagingController.itemList!.remove(circle);
      //     rootController.circlesPagingController.notifyListeners();
      //   }
      // }
    }

    return Container(
      height: Get.height * 0.25,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: context.theme.bottomSheetTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                circle.name == '' ? 'Unknown' : circle.name!.capitalizeFirst!,
                style: context.theme.textTheme.labelMedium,
              ),
            ],
          ),
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    FlutterRemix.profile_fill,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                'View profile',
                style: context.theme.textTheme.labelSmall!
                    .copyWith(letterSpacing: 1),
              ),
            ],
          ),
          // removeCircleMutation.isLoading
          //     ? LoadingAnimationWidget.staggeredDotsWave(
          //         color: AppColors.primaryYellow,
          //         size: 30.sp,
          //       )
          InkWell(
            onTap: () async {
              await handleRemoveCircle();
              Get.back();
            },
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      FlutterRemix.delete_bin_4_fill,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  'Delete',
                  style: context.theme.textTheme.labelSmall!
                      .copyWith(letterSpacing: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
