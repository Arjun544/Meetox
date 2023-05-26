import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';

class DrawerTile extends GetView<RootController> {
  const DrawerTile({
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final rootController = Get.find<RootController>();
        rootController.zoomDrawerController.close!();
        onPressed();
      },
      child: Row(
        children: [
          const SizedBox(width: 20),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.customGrey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: title == 'Logout' ? Colors.red : AppColors.customBlack,
                size: 16.h,
              ),
            ),
          ),
          const SizedBox(width: 18),
          Text(
            title,
            style: context.theme.textTheme.labelMedium!.copyWith(
              letterSpacing: 0.5,
              color: title == 'Logout' ? Colors.red : AppColors.customBlack,
            ),
          ),
        ],
      ),
    );
  }
}
