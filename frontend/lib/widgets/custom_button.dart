import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/themes/colors.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.width,
    this.text,
    required this.onPressed,
    super.key,
    this.height,
    this.icon = const SizedBox.shrink(),
    this.hasIcon = false,
    this.marginBottom = 0,
    this.color = AppColors.customBlack,
  });
  final double width;
  final double? height;
  final String? text;
  final Color color;
  final Widget icon;
  final bool hasIcon;
  final double marginBottom;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: width,
        height: height ?? 55.sp,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: marginBottom),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: text == null
            ? icon
            : hasIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      SizedBox(
                        width: 20.sp,
                      ),
                      Text(
                        text ?? '',
                        style: context.theme.textTheme.labelMedium!.copyWith(
                          color: color != context.theme.cardColor
                              ? context.theme.textTheme.labelMedium!.color
                              : Colors.white,
                        ),
                      ),
                    ],
                  )
                : Text(
                    text?? '',
                    style: context.theme.textTheme.labelMedium!.copyWith(
                      color: color != context.theme.cardColor
                          ? context.theme.textTheme.labelMedium!.color
                          : Colors.white,
                    ),
                  ),
      ),
    );
  }
}
