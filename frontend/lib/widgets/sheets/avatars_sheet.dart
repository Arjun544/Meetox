import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';

class AvatarsSheet extends StatelessWidget {
  const AvatarsSheet({
    required this.selectedAvatar,
    required this.avatars,
    super.key,
  });
  final RxInt selectedAvatar;
  final List<String> avatars;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.6,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: context.theme.dialogBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Click to select an avatar',
            style: context.theme.textTheme.labelSmall,
          ),
          SizedBox(height: 20.sp),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => selectedAvatar.value = index,
                  child: Obx(
                    () => DecoratedBox(
                      decoration: BoxDecoration(
                        color: selectedAvatar.value == index
                            ? AppColors.primaryYellow
                            : context.theme.dialogBackgroundColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            avatars[index],
                            height: 80.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
