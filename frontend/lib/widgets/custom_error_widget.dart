import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_text_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    required this.image,
    required this.text,
    required this.onPressed,
    super.key,
    this.btnText = 'Try Again',
    this.isWarining = false,
  });
  final String image;
  final String text;
  final String btnText;
  final bool isWarining;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Swing(
          child: SvgPicture.asset(
            image,
            height: 100.sp,
          ),
        ),
        Text(
          text,
          style: context.theme.textTheme.labelSmall,
        ),
        if (!isWarining)
          CustomTextButton(
            text: btnText,
            onPressed: onPressed,
            color: AppColors.primaryYellow,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
