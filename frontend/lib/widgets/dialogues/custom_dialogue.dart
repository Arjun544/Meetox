
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_text_button.dart';

class CustomDialogue extends StatelessWidget {

  const CustomDialogue(
      {required this.title, required this.subTitle, required this.icon, required this.btnText, required this.onPressed, super.key,});
  final String title;
  final String subTitle;
  final IconData icon;
  final String btnText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 200.h, horizontal: 15.w),
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
                  icon,
                  size: 35.sp,
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
                subTitle,
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
                color: context.theme.textTheme.headline5!.color!,
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
