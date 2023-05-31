import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/imports/core_imports.dart';

class CustomCloseButton extends StatelessWidget {
  final VoidCallback onTap;

  const CustomCloseButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.theme.dialogBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            FlutterRemix.close_fill,
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}
