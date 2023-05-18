import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';

class ButtonLoader extends StatelessWidget {

  const ButtonLoader({
    required this.width, super.key,
    this.height,
    this.isMini = false,
    this.color = AppColors.customBlack,
    this.loaderColor = AppColors.primaryYellow,
  });
  final double width;
  final double? height;
  final Color color;
  final bool isMini;
  final Color loaderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 55.sp,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(isMini ? 10 : 15),
      ),
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: loaderColor,
        size: 20.sp,
      ),
    );
  }
}
