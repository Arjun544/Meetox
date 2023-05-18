import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_text_button.dart';

class LocationPermissionDialogue extends StatelessWidget {
  const LocationPermissionDialogue({
    required this.title,
    required this.btnText,
    required this.onPressed,
    super.key,
  });
  final String title;
  final String btnText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: Get.height * 0.3, horizontal: 15.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: context.theme.floatingActionButtonTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              SizedBox(height: 10.sp),
              Pulse(
                infinite: true,
                duration: const Duration(milliseconds: 1500),
                child: Icon(
                  FlutterRemix.map_pin_fill,
                  size: 40.sp,
                ),
              ),
              SizedBox(height: 10.sp),
            ],
          ),
          Column(
            children: [
              Text(
                title,
                style: context.theme.textTheme.labelMedium,
              ),
              SizedBox(height: 20.sp),
              Text(
                'To connect with nearby people, circles & questions on Meetox, allow access to your location',
                textAlign: TextAlign.center,
                style: context.theme.textTheme.labelSmall,
              ),
            ],
          ),
          Column(
            children: [
              CustomTextButton(
                text: btnText,
                color: AppColors.primaryYellow,
                onPressed: onPressed,
              ),
              CustomTextButton(
                text: 'Later',
                color: context.theme.textTheme.labelSmall!.color!,
                onPressed: Get.back,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
